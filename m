Return-Path: <linux-kernel+bounces-772827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F45B2980B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A79E5E1684
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0E426E6FF;
	Mon, 18 Aug 2025 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S9ErmpTX"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9582690ED
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490389; cv=none; b=TJBxqru12mdKTOT9ZC1Mbz+PojCB4Ob/M5eJgG6qOaY8I3F/9bzPtIqGjPYaR80ms5tsjccileuvSIFW0tqo7Lkt7fsGzlAY8VMN9JOM5Qv9C05e+gbrMkf0ZtJJZfK50uzJYKVWUnLLOUKMjLrI+9qVQZKOCeLDCXemlUHQvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490389; c=relaxed/simple;
	bh=9HcW+TBvPJK2/+LEsOOqVgiuAIV/UKwGcXz7n5w/VEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=si/yxzdyaWX6UPeVAtDijfGNCtd2lrXMzH/usczz+xITTAk6VODZQHyAqnbUw9i4IA05wnBpTnnfwanov18r0WKanLjoWLl7hs8oXGw8EI6uQJeZqbpH4s3hOrYJL+sNo9DjrPGiXW2dxK2fMLFgyOMnJqxYQGpXGj6y9EFjFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=S9ErmpTX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445806c2ddso31494445ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490387; x=1756095187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h5FwLL2itI1aaIPBkXXTJzNb4MmDc/qgyBrNo+u9DI=;
        b=S9ErmpTX2mlsGU9kRNPX83oUmghCYUOxaA7iRCqSTuH2zSPBRQpu7WkwD3R68xw4P2
         hpjsx+rHfEvl1cbx5WcmeiGw8Jn3VoTnS3p/89F7JQqI/aKRWtMatQBxxIIDbnpKoko7
         GjJPsvMl+Xe5xmxCHgJK8PYIkJM15qs8Bq6PgNyiIaesmqVyBrHf8XVWNQR0xTh9ceBm
         Zx5ti6zV2UYGiD5G/ha4CuHVpJivaRn2Ppj+zEwr0lvLFuZXt2PJZVog/pSIKjHvSi72
         2YCIn1EG4dqiYvnNebQlxJYhvLefIJOj5cbdOTYok/8xp54BxGsvy4EJQtOgqHf1nsQM
         VzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490387; x=1756095187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h5FwLL2itI1aaIPBkXXTJzNb4MmDc/qgyBrNo+u9DI=;
        b=KZj/XyQRwCGg1X5s7KbbJcrga4+wXvmaTVLDhUQUbbuJGtHmTYPaW/UxTgbu2PKkgW
         iHi7G+X1+GAgXFeCBHwpYymaWCJ21UHeArATWK+nUG0zz7kc8UpkSI4VhDTxex61t194
         shWj2I4pRMLTK1SS0u8bCGSD4PvtEWAKn6yAcsKvuYgLCBJv5bS0CN0w4IVG+M4UT06z
         BMqv4OCAsg1cThLubjYIxmgDbnhHKC6X1+ZerrhqQ8BECoHlfS3vt2CHXQECIxwu2LtV
         cZex2jmusBRSc+2U37Td3ZeYai7dVkVpjPC9K3zPu40M1TOcfC1KC1Ox8zXN+7/HsB2N
         Z96A==
X-Forwarded-Encrypted: i=1; AJvYcCWBptsuOOZnUqOTQl7NzbXc/RzWICzfU7jQIm5T8q42b16Crm0pF2IxuhQpv0mCWvt9vIWLbO1i8c4zhrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEX+cnLZdAhBzG7LXv6YJf3jS7vVdBpn/KdM1iVXBEJL9B4blD
	lpiwgJ7nXcmIOx4uIoqBTnNGZ79PPQJl9MGoCRxGm+3VKI3Dfu7DDHJjWQye7yGuWTs=
X-Gm-Gg: ASbGncsiLkTG2WxX+J4pGLuxQT5+MEfIkewUu0tmkqhnuZQC2iQNCzkAokHRuD1Ju8R
	Cu8JU8TvLJEqJYAFn6bodrhejm0MF++yiyANotGX2ZLqkMMc3in8AtzijSUdj11NkXMQDJ2dTCp
	Tgn5DnWsOoKB0nlldE0Lv13GCBgvOXoIrEJgX9HbYo0jCsT4lUhGgGIZ/iYb73tr9MEH5omSMV3
	Wm0YG7m7TU4dTVb7QT0UCJ/6o0hYuZw1Qb3SNprQh+Gr1/4RMsJXXgQA9yxdHswiGZINjIkyTnz
	kmfLT6A4gPyLLgoZ2buksS51MVE302RZlrwSoKuglKyuOnzXVe1AocWIVBemgBclFlk5uWzTU2Y
	E1uTeCvjUEJHCNqlIKQM9T2l4yqNoGvLhh9yXE3wSf3CAPyDRrO07CwIfMWR20B+T
X-Google-Smtp-Source: AGHT+IGkH4BDAXF4edn8TwIvvipLqLI6fuRlMJ8wwuhqVGiG5/9vRp54UNterQDaAwLw9x2Gzg+I7w==
X-Received: by 2002:a17:902:d50d:b0:244:6860:2f10 with SMTP id d9443c01a7336-2446d6d2d44mr179006705ad.1.1755490386542;
        Sun, 17 Aug 2025 21:13:06 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:13:05 -0700 (PDT)
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
Subject: [PATCH v10 22/24] irqchip/riscv-rpmi-sysmsi: Add ACPI support
Date: Mon, 18 Aug 2025 09:39:18 +0530
Message-ID: <20250818040920.272664-23-apatel@ventanamicro.com>
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

Add ACPI support for the RISC-V RPMI system MSI based irqchip driver.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                 |  2 +-
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c | 47 +++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e047ba36df16..a61c6dc63c29 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -636,7 +636,7 @@ config RISCV_IMSIC
 
 config RISCV_RPMI_SYSMSI
 	bool
-	depends on MAILBOX
+	depends on RISCV && MAILBOX
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
 	default RISCV
diff --git a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
index 92e8847dfccc..5c74c561ce31 100644
--- a/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
+++ b/drivers/irqchip/irq-riscv-rpmi-sysmsi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2025 Ventana Micro Systems Inc. */
 
+#include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/bug.h>
 #include <linux/device.h>
@@ -9,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/module.h>
@@ -209,6 +211,8 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpmi_sysmsi_priv *priv;
+	struct fwnode_handle *fwnode;
+	u32 id;
 	int rc;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -239,6 +243,22 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 	}
 	priv->nr_irqs = rc;
 
+	fwnode = dev_fwnode(dev);
+	if (is_acpi_node(fwnode)) {
+		u32 nr_irqs;
+
+		rc = riscv_acpi_get_gsi_info(fwnode, &priv->gsi_base, &id,
+					     &nr_irqs, NULL);
+		if (rc) {
+			dev_err(dev, "failed to find GSI mapping\n");
+			return rc;
+		}
+
+		/* Update with actual GSI range */
+		if (nr_irqs != priv->nr_irqs)
+			riscv_acpi_update_gsi_range(priv->gsi_base, priv->nr_irqs);
+	}
+
 	/*
 	 * The device MSI domain for platform devices on RISC-V architecture
 	 * is only available after the MSI controller driver is probed so,
@@ -252,8 +272,15 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 		 * then we need to set it explicitly before using any platform
 		 * MSI functions.
 		 */
-		if (dev_of_node(dev))
+		if (is_of_node(fwnode)) {
 			of_msi_configure(dev, dev_of_node(dev));
+		} else if (is_acpi_device_node(fwnode)) {
+			struct irq_domain *msi_domain;
+
+			msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+							      DOMAIN_BUS_PLATFORM_MSI);
+			dev_set_msi_domain(dev, msi_domain);
+		}
 
 		if (!dev_get_msi_domain(dev)) {
 			mbox_free_channel(priv->chan);
@@ -268,6 +295,13 @@ static int rpmi_sysmsi_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -ENOMEM, "failed to create MSI irq domain\n");
 	}
 
+#ifdef CONFIG_ACPI
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev)
+		acpi_dev_clear_dependencies(adev);
+#endif
+
 	dev_info(dev, "%u system MSIs registered\n", priv->nr_irqs);
 	return 0;
 }
@@ -277,10 +311,17 @@ static const struct of_device_id rpmi_sysmsi_match[] = {
 	{}
 };
 
+static const struct acpi_device_id acpi_rpmi_sysmsi_match[] = {
+	{ "RSCV0006" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_rpmi_sysmsi_match);
+
 static struct platform_driver rpmi_sysmsi_driver = {
 	.driver = {
-		.name		= "rpmi-sysmsi",
-		.of_match_table	= rpmi_sysmsi_match,
+		.name			= "rpmi-sysmsi",
+		.of_match_table		= rpmi_sysmsi_match,
+		.acpi_match_table	= acpi_rpmi_sysmsi_match,
 	},
 	.probe = rpmi_sysmsi_probe,
 };
-- 
2.43.0


