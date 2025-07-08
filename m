Return-Path: <linux-kernel+bounces-720973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB3CAFC2C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD471AA77E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07C2248BA;
	Tue,  8 Jul 2025 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CavCen+R"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC95223DE8;
	Tue,  8 Jul 2025 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956258; cv=none; b=oYTgFxrrCTIwjm42tvQY+P6hLwvMim/9Bupdt3nnXxvMBRhakvEecRwC3nEKDi24HD+utcG9ye6F/Zu3DvqiawG65p3Pms4HbLjTQupDbFxVrWsW0j3ctBRQuKzuutfEcEvQ4KzoiL+3lVhcAYAhmQmlyZWF5ad/JqbpWo8QeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956258; c=relaxed/simple;
	bh=19BskVBzUcBsQWFTrOA2NAAqMCiqh3tT2zrmepFADmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAbomg3jZ3e2HnpOEHqiiGK6zHHb26O9MdIDtHjiJBMyCnhJdDHdk+std7JsdCPvC60UijIGENlSxzOM715UT67DgyWse5d5aImMtQFhWNM+u5Q9ZaMW9f7CqJFsSoZJMbSznvn6LVVyoAh+Hfyzrb8ryKXvSsFmZjXunF/t308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CavCen+R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234f17910d8so35288455ad.3;
        Mon, 07 Jul 2025 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751956256; x=1752561056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgtcCxhmZdnPAQq2J//8hYagFuErKydvAl0n9hMEJuw=;
        b=CavCen+RW993RzQEEhTxv5O3r3SoyB4XX1bKFt8knwFlAr6ticbIh3fwymzxswx2+v
         CPVZ8KehVSDa7RI/aUrdmWaYvkeTfgCn1zJJJuNBuenWD/rri0Ijshk08rCzYwPEDFtd
         C77E+USi5kbevPxUXcQGtnZ7uOAIbhcvGC3N1fhatTEXTMYfBFZOofhdnABWAhn6X7yL
         1JaBTDGuEdXi3Q2ongT1N4h3S9Xukcw00YxJDcYGGeufjQNqLuNKMGiF8lI37pRcgYBd
         9kQ0K6+CBUrA1J3LF32Ph6N9CkvaMQtwTZAF0O8rutmFenhGNH9hWgnEMgTK6Zqq0yUo
         uLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751956256; x=1752561056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgtcCxhmZdnPAQq2J//8hYagFuErKydvAl0n9hMEJuw=;
        b=q9JhRPmUXaXz2n2LrCCXXwVSYaNw6TqhXE5KVCLXGvirgUIM+Sh/7Bn9iGrnb2bdTF
         6aPLeyZUqSmQvPDuzbFmmdgF3aqRdvYTHRJZCy9+sh6iU2SA1a/r89Y9YV19UXjpw/tg
         1+XiJqR5kYYFOUZXZbckfRGseh+fT3+AFjoqj21qDorCBZGqEG37erpdyOo27QwiPc2e
         3KrVKlscTeohiHH289Ay8dT2IHonZoIfEHHZXg2FWVZ5SXBgFfPkUFqzisBVd+k/3OO6
         Q4RgDis9K77SQsdrl1bv3lkSh+cN1+34dS+qH47wqTA9W+uy5hAtuo7H6WxHi2sYkzey
         cYng==
X-Forwarded-Encrypted: i=1; AJvYcCVvVRH5jFW2+h9/VHoX1HYW0ESXXv656ikgsBdBsjYAKhhvvvwdczKtRPiJRYIIiZ9iXVHGc4jvLjRr8ef8@vger.kernel.org, AJvYcCXkorY0AScHMXXSQ9wHK7gcCz1iJi/gCyYnXkAIVMlMkOYuQFt6j9V+wN1MJpxtYECv2OafZyklmHxN@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+zosCK9VmdKyG/QhB8IgAT/AqGWP7HUaMORmUy7ZlYKiM9bu
	s9/YgyiU+H097RVqtIXESYpO6jDPqjVoZFSzhIw2l9Wh+KJiR4cWfLTzJhxdKR9Nq4s=
X-Gm-Gg: ASbGnculQuegndNm+Zvn4C8APXxdIfDyxXozrFHyyUbvSXX2O7yohMiRNjXVsYgTg/0
	PCMLAAsiKM4vObUvA7KWyRZG3RZbhTr1lBEZYIo1Zj4mzRLcLOyQIH6TyKUExWndk/iF7JasGPI
	Ldhf9pTwjzIqmyTpKb2dUOPMWvLwGzW5DXsaNnszb2Kpx82wWD0AuL4HRK7RxFjNHm60vc6eYnR
	uDCHmsYY/1akKyVbdJTV6HJz+K1aD2WmStoAt+NjyhdIWuOc5bQNRUiZ9gBE3+Fcqv3qRfspSW/
	js+//49HmcW7rrkbi5U4AhLxftWGzGib0nH94bXGWfu3KWjpk8iSkKrUSKUHvg==
X-Google-Smtp-Source: AGHT+IEHaKDnutmLE4TaqX3rV/8SGpSNjJFcfnVNZNoSPdwlmSzOuB4rVAWhWHt428WpS+ewzou8bA==
X-Received: by 2002:a17:903:1a08:b0:236:6fbb:a5f3 with SMTP id d9443c01a7336-23dd0b16a81mr36467735ad.40.1751956256370;
        Mon, 07 Jul 2025 23:30:56 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c845be91esm100729455ad.250.2025.07.07.23.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:30:56 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH v5 2/2] phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
Date: Tue,  8 Jul 2025 14:30:37 +0800
Message-ID: <20250708063038.497473-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708063038.497473-1-inochiama@gmail.com>
References: <20250708063038.497473-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X. Currently
this driver does not support OTG mode as lack of document.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/phy/Kconfig                  |   1 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/sophgo/Kconfig           |  19 +++
 drivers/phy/sophgo/Makefile          |   2 +
 drivers/phy/sophgo/phy-cv1800-usb2.c | 170 +++++++++++++++++++++++++++
 5 files changed, 193 insertions(+)
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb2.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 58c911e1b2d2..678dd0452f0a 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -122,6 +122,7 @@ source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
 source "drivers/phy/socionext/Kconfig"
+source "drivers/phy/sophgo/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/starfive/Kconfig"
 source "drivers/phy/sunplus/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c670a8dac468..bfb27fb5a494 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -35,6 +35,7 @@ obj-y					+= allwinner/	\
 					   rockchip/	\
 					   samsung/	\
 					   socionext/	\
+					   sophgo/	\
 					   st/		\
 					   starfive/	\
 					   sunplus/	\
diff --git a/drivers/phy/sophgo/Kconfig b/drivers/phy/sophgo/Kconfig
new file mode 100644
index 000000000000..2c943bbe1f81
--- /dev/null
+++ b/drivers/phy/sophgo/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Phy drivers for Sophgo platforms
+#
+
+if ARCH_SOPHGO || COMPILE_TEST
+
+config PHY_SOPHGO_CV1800_USB2
+	tristate "Sophgo CV18XX/SG200X USB 2.0 PHY support"
+	depends on MFD_SYSCON
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB 2.0 PHY used with
+	  the DWC2 USB controller in Sophgo CV18XX/SG200X
+	  series SoC.
+	  If unsure, say N.
+
+endif # ARCH_SOPHGO || COMPILE_TEST
diff --git a/drivers/phy/sophgo/Makefile b/drivers/phy/sophgo/Makefile
new file mode 100644
index 000000000000..318060661759
--- /dev/null
+++ b/drivers/phy/sophgo/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_SOPHGO_CV1800_USB2)	+= phy-cv1800-usb2.o
diff --git a/drivers/phy/sophgo/phy-cv1800-usb2.c b/drivers/phy/sophgo/phy-cv1800-usb2.c
new file mode 100644
index 000000000000..64f8e37b4b52
--- /dev/null
+++ b/drivers/phy/sophgo/phy-cv1800-usb2.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Inochi Amaoto <inochiama@outlook.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+#define REG_USB_PHY_CTRL		0x048
+
+#define PHY_VBUS_POWER_EN		BIT(0)
+#define PHY_VBUS_POWER			BIT(1)
+#define PHY_ID_OVERWRITE_EN		BIT(6)
+#define PHY_ID_OVERWRITE_MODE		BIT(7)
+#define PHY_ID_OVERWRITE_MODE_HOST	FIELD_PREP(BIT(7), 0)
+#define PHY_ID_OVERWRITE_MODE_DEVICE	FIELD_PREP(BIT(7), 1)
+
+#define PHY_APP_CLK_RATE		125000000
+#define PHY_LPM_CLK_RATE		12000000
+#define PHY_STB_CLK_RATE		333334
+
+struct cv1800_usb_phy {
+	struct phy	*phy;
+	struct regmap	*syscon;
+	spinlock_t	lock;
+	struct clk	*usb_app_clk;
+	struct clk	*usb_lpm_clk;
+	struct clk	*usb_stb_clk;
+	bool		support_otg;
+};
+
+static int cv1800_usb_phy_set_mode(struct phy *_phy,
+				   enum phy_mode mode, int submode)
+{
+	struct cv1800_usb_phy *phy = phy_get_drvdata(_phy);
+	unsigned int regval = 0;
+	int ret;
+
+	dev_info(&phy->phy->dev, "set mode %d", (int)mode);
+
+	switch (mode) {
+	case PHY_MODE_USB_DEVICE:
+		regval = PHY_ID_OVERWRITE_EN | PHY_ID_OVERWRITE_MODE_DEVICE;
+		regmap_clear_bits(phy->syscon, REG_USB_PHY_CTRL, PHY_VBUS_POWER);
+		break;
+	case PHY_MODE_USB_HOST:
+		regval = PHY_ID_OVERWRITE_EN | PHY_ID_OVERWRITE_MODE_HOST;
+		regmap_set_bits(phy->syscon, REG_USB_PHY_CTRL, PHY_VBUS_POWER);
+		break;
+	case PHY_MODE_USB_OTG:
+		if (!phy->support_otg)
+			return 0;
+
+		ret = regmap_read(phy->syscon, REG_USB_PHY_CTRL, &regval);
+		if (ret)
+			return ret;
+
+		regval = FIELD_GET(PHY_ID_OVERWRITE_MODE, regval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(phy->syscon, REG_USB_PHY_CTRL,
+				  PHY_ID_OVERWRITE_EN | PHY_ID_OVERWRITE_MODE,
+				  regval);
+}
+
+static int cv1800_usb_phy_set_clock(struct cv1800_usb_phy *phy)
+{
+	int ret;
+
+	ret = clk_set_rate(phy->usb_app_clk, PHY_APP_CLK_RATE);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(phy->usb_lpm_clk, PHY_LPM_CLK_RATE);
+	if (ret)
+		return ret;
+
+	return clk_set_rate(phy->usb_stb_clk, PHY_STB_CLK_RATE);
+}
+
+static const struct phy_ops cv1800_usb_phy_ops = {
+	.set_mode	= cv1800_usb_phy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static int cv1800_usb_phy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *parent = dev->parent;
+	struct cv1800_usb_phy *phy;
+	struct phy_provider *phy_provider;
+	int ret;
+
+	if (!parent)
+		return -ENODEV;
+
+	phy = devm_kmalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->syscon = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR_OR_NULL(phy->syscon))
+		return -ENODEV;
+
+	phy->support_otg = false;
+
+	spin_lock_init(&phy->lock);
+
+	phy->usb_app_clk = devm_clk_get_enabled(dev, "app");
+	if (IS_ERR(phy->usb_app_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_app_clk),
+			"Failed to get app clock\n");
+
+	phy->usb_lpm_clk = devm_clk_get_enabled(dev, "lpm");
+	if (IS_ERR(phy->usb_lpm_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_lpm_clk),
+			"Failed to get lpm clock\n");
+
+	phy->usb_stb_clk = devm_clk_get_enabled(dev, "stb");
+	if (IS_ERR(phy->usb_stb_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->usb_stb_clk),
+			"Failed to get stb clock\n");
+
+	phy->phy = devm_phy_create(dev, NULL, &cv1800_usb_phy_ops);
+	if (IS_ERR(phy->phy))
+		return dev_err_probe(dev, PTR_ERR(phy->phy),
+			"Failed to create phy\n");
+
+	ret = cv1800_usb_phy_set_clock(phy);
+	if (ret)
+		return ret;
+
+	phy_set_drvdata(phy->phy, phy);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id cv1800_usb_phy_ids[] = {
+	{ .compatible = "sophgo,cv1800b-usb2-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cv1800_usb_phy_ids);
+
+static struct platform_driver cv1800_usb_phy_driver = {
+	.probe = cv1800_usb_phy_probe,
+	.driver = {
+		.name = "cv1800-usb2-phy",
+		.of_match_table = cv1800_usb_phy_ids,
+	 },
+};
+module_platform_driver(cv1800_usb_phy_driver);
+
+MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
+MODULE_DESCRIPTION("CV1800/SG2000 SoC USB 2.0 PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.50.0


