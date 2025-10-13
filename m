Return-Path: <linux-kernel+bounces-851114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF07ABD592A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9FF18A5CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056452C15B6;
	Mon, 13 Oct 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0JwQ+84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE7C28000B;
	Mon, 13 Oct 2025 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377671; cv=none; b=c8BPFZ+RB+7GDM9lLv/mT+yjoLHHsfLbkzaVYzQSlS95t7SFD2raM4kyVypdDmh0DDz2hGJokqGAUmj3/qzXNX8J5r8l1cZOMECh6LlfBaxqJQexbRjvjOKt9FtFABt0+OBTSZ3W+GRu4onBUjhOv4EdE5N06/gs7MWHh4BvmdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377671; c=relaxed/simple;
	bh=LLvPaeaDgbN1v+SEvOddhb8/ImHBKYgsCBzaGq5fKtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrvdUEg6254s+M8Zypuqc3Ua4hLzTeDeX413FzbHTSM7+EaMp0f5LOkPB5DGZDZvqqHAKuum+Ykf2SO41plVJKnHnn8Fu9g/hM3Th5QuF2a6nbt2qy0soc+Co+aZ51pXH59RuspNbUHpetEdDaDsBGL1XeciDlNnKJxnatqDDQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0JwQ+84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8AAC116C6;
	Mon, 13 Oct 2025 17:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377671;
	bh=LLvPaeaDgbN1v+SEvOddhb8/ImHBKYgsCBzaGq5fKtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h0JwQ+84uewBHrXs9AI4/ypHaJbeDEwnizotdzk6OnMnmWjSUbqGFwXpaFFCk1gcC
	 epFf6J+sEHv7nRQq/UOVQ5jFQ1tL3s6xsuBDRUYBd2B3MYB0o4EQc/OacNOucI6pec
	 ZYzWmzpIF3Ki/UfgczQTzZw3BUFLMz7IEZgeTuj+IR1cONMdbS6O/n15Yf1Z6TgHeg
	 b9I0ahl7f96w1wjyx5y0ydM14P2y728ChzZbmFLRwAL5WvBtxsknBHMLLXKkyoUquq
	 Ku7T/19s9Lga9cxD4mio/+zlvtYgBmToCiyHPlVnN48P0hotYCsqE4SPABBtXBOedF
	 3SxLHe774FEnA==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/9] soc: microchip: add mfd drivers for two syscon regions on PolarFire SoC
Date: Mon, 13 Oct 2025 18:45:34 +0100
Message-ID: <20251013-patient-matrimony-6162c8f92e2e@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4873; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Lcc0lHBfQVQLXEUPw6TwgGGxT3tWaxaoKaJLIXpLxZk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlvrfYHrq+Tdn3saNaw9g6fxLxbz3ZPiGgM1VZb0tN5T mql2NTIjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzE/CnDP60js/m5VB3yCm7I /dz79ablA8ZN5/K13l8qXZTD96ykSI2RYbccs9Ir4d0l3/ImnN7ok8HifMQkaeWuyxanpTZKBef 4MAIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The control-scb and mss-top-sysreg regions on PolarFire SoC both fulfill
multiple purposes. The former is used for mailbox functions in addition
to the temperature & voltage sensor while the latter is used for clocks,
resets, interrupt muxing and pinctrl.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/Kconfig               | 13 ++++++
 drivers/soc/microchip/Makefile              |  1 +
 drivers/soc/microchip/mpfs-control-scb.c    | 45 +++++++++++++++++++
 drivers/soc/microchip/mpfs-mss-top-sysreg.c | 48 +++++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 drivers/soc/microchip/mpfs-control-scb.c
 create mode 100644 drivers/soc/microchip/mpfs-mss-top-sysreg.c

diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
index 19f4b576f822..31d188311e05 100644
--- a/drivers/soc/microchip/Kconfig
+++ b/drivers/soc/microchip/Kconfig
@@ -9,3 +9,16 @@ config POLARFIRE_SOC_SYS_CTRL
 	  module will be called mpfs_system_controller.
 
 	  If unsure, say N.
+
+config POLARFIRE_SOC_SYSCONS
+	bool "PolarFire SoC (MPFS) syscon drivers"
+	default y
+	depends on ARCH_MICROCHIP
+	select MFD_CORE
+	help
+	  These drivers add support for the syscons on PolarFire SoC (MPFS).
+	  Without these drivers core parts of the kernel such as clocks
+	  and resets will not function correctly.
+
+	  If unsure, and on a PolarFire SoC, say y.
+
diff --git a/drivers/soc/microchip/Makefile b/drivers/soc/microchip/Makefile
index 14489919fe4b..1a3a1594b089 100644
--- a/drivers/soc/microchip/Makefile
+++ b/drivers/soc/microchip/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_POLARFIRE_SOC_SYS_CTRL)	+= mpfs-sys-controller.o
+obj-$(CONFIG_POLARFIRE_SOC_SYSCONS)	+= mpfs-control-scb.o mpfs-mss-top-sysreg.o
diff --git a/drivers/soc/microchip/mpfs-control-scb.c b/drivers/soc/microchip/mpfs-control-scb.c
new file mode 100644
index 000000000000..d1a8e79c232e
--- /dev/null
+++ b/drivers/soc/microchip/mpfs-control-scb.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/array_size.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+static const struct mfd_cell mpfs_control_scb_devs[] = {
+	{ .name = "mpfs-tvs", },
+};
+
+static int mpfs_control_scb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_control_scb_devs,
+			      1, NULL, 0, NULL);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id mpfs_control_scb_of_match[] = {
+	{.compatible = "microchip,mpfs-control-scb", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpfs_control_scb_of_match);
+
+static struct platform_driver mpfs_control_scb_driver = {
+	.driver = {
+		.name = "mpfs-control-scb",
+		.of_match_table = mpfs_control_scb_of_match,
+	},
+	.probe = mpfs_control_scb_probe,
+};
+module_platform_driver(mpfs_control_scb_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("PolarFire SoC control scb driver");
diff --git a/drivers/soc/microchip/mpfs-mss-top-sysreg.c b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
new file mode 100644
index 000000000000..9b2e7b84cdba
--- /dev/null
+++ b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/array_size.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+static const struct mfd_cell mpfs_mss_top_sysreg_devs[] = {
+	{ .name = "mpfs-reset", },
+};
+
+static int mpfs_mss_top_sysreg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_mss_top_sysreg_devs,
+			      1, NULL, 0, NULL);
+	if (ret)
+		return ret;
+
+	if (devm_of_platform_populate(dev))
+		dev_err(dev, "Error populating children\n");
+
+	return 0;
+}
+
+static const struct of_device_id mpfs_mss_top_sysreg_of_match[] = {
+	{.compatible = "microchip,mpfs-mss-top-sysreg", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mpfs_mss_top_sysreg_of_match);
+
+static struct platform_driver mpfs_mss_top_sysreg_driver = {
+	.driver = {
+		.name = "mpfs-mss-top-sysreg",
+		.of_match_table = mpfs_mss_top_sysreg_of_match,
+	},
+	.probe = mpfs_mss_top_sysreg_probe,
+};
+module_platform_driver(mpfs_mss_top_sysreg_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("PolarFire SoC mss top sysreg driver");
-- 
2.51.0


