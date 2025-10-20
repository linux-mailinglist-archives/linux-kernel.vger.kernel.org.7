Return-Path: <linux-kernel+bounces-861503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C58BF2E43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0280146115B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BA03328EC;
	Mon, 20 Oct 2025 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="uJl4bvbl"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2553321BF;
	Mon, 20 Oct 2025 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984117; cv=none; b=YkbH45cmjtGxvs6WPjUawghik0l9jQ9qQIEck58wmlr/14w2ug3tmSvYpWiT9uzpNLfd6SVloSpg50vCwDTkkIQhy/0zCosxb015eI1Z6jXq/GgTU6H5TgWjB9FMZDDIedu5o1g2xRUofOR56d6/iBBTVExWOI4saCXxBr3eRRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984117; c=relaxed/simple;
	bh=iXt6vpEl2GY8CP1Su70xln432WueQBOJIcmDL+8m6KI=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jE1aJlq4hW98VVAiLKzwFq2iQ/qAwZV1NF+wJoiFYizYdNENHHovvVPSFWUl8JBkahqUlXIiR/f2RhReG9p5sbZy0gXMMU5F+2cXu98UeuqQphQcs3eZ2wEdjMWH1y1+925CPQlI8gFNiMBA6CCidy7lnqxWmVinHYUDmt/9AnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=uJl4bvbl; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 9FD9B8288084;
	Mon, 20 Oct 2025 13:15:14 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jqNUTe8Wk7Co; Mon, 20 Oct 2025 13:15:13 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 69ABA8288916;
	Mon, 20 Oct 2025 13:15:13 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 69ABA8288916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760984113; bh=4vKxjpiVAaNQ9JHmxNGsHFr/xYTBTH95LrQ0W9ZsgR8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=uJl4bvblqWnZ+3y/ttcSE4fikI8NUYUX8Ac+zpWeJp/VZ4RVbSUhG9OnR+M48sqtq
	 /PpZgOLpTEp/j5tPSILbLlaiEgCAApThs6J3ZkuCHeBNIyJk8OpzGJ47tQoV3vJhsz
	 ruVnsziWDyuyp1Q1YT436HIE0u8wIh99cyVysmWQ=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zAgbONBYsYxB; Mon, 20 Oct 2025 13:15:13 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 3D5518288084;
	Mon, 20 Oct 2025 13:15:13 -0500 (CDT)
Date: Mon, 20 Oct 2025 13:15:13 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Message-ID: <1149130558.1802047.1760984113046.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <69142127.1802045.1760984091439.JavaMail.zimbra@raptorengineeringinc.com>
References: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com> <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com> <13657666.1802042.1760984066594.JavaMail.zimbra@raptorengineeringinc.com> <69142127.1802045.1760984091439.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v4 4/4] watchdog: sony-cronos-smc: Add watchdog driver for
 Sony  Cronos SMC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: watchdog: sony-cronos-smc: Add watchdog driver for Sony Cronos SMC
Thread-Index: 2sKQBCK/cFq8bcVeB0FycJRZCrk72uhu0OzSZMBtKSw5MQvtthqvlHEl

The Sony Cronos Platform Controller is a multi-purpose platform controller with
an integrated watchdog.  Add the watchdog driver for the Cronos SMC.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/watchdog/Kconfig           |  17 ++
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/sony-cronos-wdt.c | 283 +++++++++++++++++++++++++++++
 3 files changed, 301 insertions(+)
 create mode 100644 drivers/watchdog/sony-cronos-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 05008d937e40..843ee5f8d750 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -416,6 +416,23 @@ config SL28CPLD_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called sl28cpld_wdt.
 
+config SONY_CRONOS_WATCHDOG
+	tristate "Sony Cronos CPLD Watchdog"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	depends on I2C
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  for the Sony Cronos control CPLD.
+
+	  All known Cronos systems use the ASpeed AST2600 SoC,
+	  therefore the configuration option is gated on
+	  ARCH_ASPEED selection.  If this changes, add the new
+	  SoCs to the selection list.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sony-cronos-wdt.
+
 # ALPHA Architecture
 
 # ARM Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index b680e4d3c1bc..724d5982c240 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -243,3 +243,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
 obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
+obj-$(CONFIG_SONY_CRONOS_WATCHDOG) += sony-cronos-wdt.o
diff --git a/drivers/watchdog/sony-cronos-wdt.c b/drivers/watchdog/sony-cronos-wdt.c
new file mode 100644
index 000000000000..650fcee28885
--- /dev/null
+++ b/drivers/watchdog/sony-cronos-wdt.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Watchdog device driver for Sony Cronos SMCs
+ * Copyright (C) 2015 Dialog Semiconductor Ltd.
+ * Copyright (C) 2022-2025 Raptor Engineering, LLC
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/mfd/sony-cronos.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/watchdog.h>
+
+static const unsigned int wdt_timeout[] = { 10, 80 };
+static const unsigned int wdt_timeout_ctl_bits[] = { 0x1, 0x0 };
+#define CRONOS_TWDSCALE_DISABLE 0
+#define CRONOS_TWDSCALE_MIN 1
+#define CRONOS_TWDSCALE_MAX (ARRAY_SIZE(wdt_timeout) - 1)
+#define CRONOS_WDT_MIN_TIMEOUT wdt_timeout[CRONOS_TWDSCALE_MIN]
+#define CRONOS_WDT_MAX_TIMEOUT wdt_timeout[CRONOS_TWDSCALE_MAX]
+#define CRONOS_WDG_DEFAULT_TIMEOUT wdt_timeout[CRONOS_TWDSCALE_MAX]
+
+struct sony_cronos_watchdog {
+	struct sony_cronos_smc *hw;
+	struct watchdog_device wdtdev;
+};
+
+static unsigned int sony_cronos_wdt_read_timeout(struct sony_cronos_watchdog *wdt)
+{
+	unsigned int i;
+	unsigned int val;
+
+	regmap_read(wdt->hw->regmap, CRONOS_WDT_CTL_REG, &val);
+
+	for (i = CRONOS_TWDSCALE_MIN; i <= CRONOS_TWDSCALE_MAX; i++) {
+		if (wdt_timeout_ctl_bits[i] == (val & CRONOS_WDT_TIMEOUT_MASK))
+			return wdt_timeout[i];
+	}
+
+	dev_err(wdt->hw->dev, "Invalid configuration data present in watchdog control register!\n");
+	return wdt_timeout[CRONOS_WDT_MIN_TIMEOUT];
+}
+
+static unsigned int sony_cronos_wdt_timeout_to_sel(unsigned int secs)
+{
+	unsigned int i;
+
+	for (i = CRONOS_TWDSCALE_MIN; i <= CRONOS_TWDSCALE_MAX; i++) {
+		if (wdt_timeout[i] >= secs)
+			return wdt_timeout_ctl_bits[i];
+	}
+
+	return wdt_timeout_ctl_bits[CRONOS_TWDSCALE_MAX];
+}
+
+static int sony_cronos_reset_watchdog_timer(struct sony_cronos_watchdog *wdt)
+{
+	return regmap_write(wdt->hw->regmap, CRONOS_WDT_CLR_REG, CRONOS_WDT_CLR_VAL);
+}
+
+static int sony_cronos_wdt_update_timeout_register(struct sony_cronos_watchdog *wdt,
+						   unsigned int regval)
+{
+	int ret;
+
+	struct sony_cronos_smc *chip = wdt->hw;
+
+	ret = sony_cronos_reset_watchdog_timer(wdt);
+	if (ret) {
+		dev_err(wdt->hw->dev, "Watchdog failed to reset (err = %d)\n", ret);
+		goto done;
+	}
+
+	return regmap_update_bits(chip->regmap, CRONOS_WDT_CTL_REG, CRONOS_WDT_TIMEOUT_MASK,
+				  regval);
+
+done:
+	return ret;
+}
+
+static int sony_cronos_wdt_start(struct watchdog_device *wdd)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct sony_cronos_smc *chip = wdt->hw;
+	unsigned int selector;
+	int ret;
+
+	selector = sony_cronos_wdt_timeout_to_sel(wdt->wdtdev.timeout);
+	ret = sony_cronos_wdt_update_timeout_register(wdt, selector);
+	if (ret) {
+		dev_err(wdt->hw->dev, "Watchdog prestart configuration failed (err = %d)\n", ret);
+		goto done;
+	}
+
+	ret = regmap_update_bits(chip->regmap, CRONOS_WDT_CTL_REG, CRONOS_WDT_ENABLE_MASK, 1);
+
+	if (ret)
+		dev_err(wdt->hw->dev, "Watchdog failed to start (err = %d)\n", ret);
+
+done:
+	return ret;
+}
+
+static int sony_cronos_wdt_stop(struct watchdog_device *wdd)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct sony_cronos_smc *chip = wdt->hw;
+	int ret;
+
+	ret = regmap_update_bits(chip->regmap, CRONOS_WDT_CTL_REG, CRONOS_WDT_ENABLE_MASK, 1);
+	if (ret)
+		dev_err(wdt->hw->dev, "Watchdog failed to stop (err = %d)\n", ret);
+
+	return ret;
+}
+
+static int sony_cronos_wdt_ping(struct watchdog_device *wdd)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	int ret;
+
+	/*
+	 * Prevent pings from occurring late in system poweroff/reboot sequence
+	 * and possibly locking out restart handler from accessing i2c bus.
+	 */
+	if (system_state > SYSTEM_RUNNING)
+		return 0;
+
+	ret = sony_cronos_reset_watchdog_timer(wdt);
+	if (ret)
+		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n", ret);
+
+	return ret;
+}
+
+static int sony_cronos_wdt_set_timeout(struct watchdog_device *wdd, unsigned int timeout)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int selector;
+	int ret;
+
+	selector = sony_cronos_wdt_timeout_to_sel(timeout);
+	ret = sony_cronos_wdt_update_timeout_register(wdt, selector);
+	if (ret)
+		dev_err(wdt->hw->dev, "Failed to set watchdog timeout (err = %d)\n", ret);
+	else
+		wdd->timeout = wdt_timeout[selector];
+
+	return ret;
+}
+
+static int sony_cronos_wdt_restart(struct watchdog_device *wdd, unsigned long action, void *data)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct i2c_client *client = to_i2c_client(wdt->hw->dev);
+	int ret;
+
+	/* Don't use regmap because it is not atomic safe */
+	ret = i2c_smbus_write_byte_data(client, CRONOS_WDT_CTL_REG, CRONOS_WDT_CTL_RESET_VAL);
+	ret = i2c_smbus_write_byte_data(client, CRONOS_BMC_RESET_REG, CRONOS_BMC_RESET_VAL);
+	if (ret < 0)
+		dev_alert(wdt->hw->dev, "Failed to shutdown (err = %d)\n", ret);
+
+	/* wait for reset to assert... */
+	mdelay(500);
+
+	return ret;
+}
+
+static const struct watchdog_info sony_cronos_watchdog_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "Sony Cronos WDT",
+};
+
+static const struct watchdog_ops sony_cronos_watchdog_ops = {
+	.owner = THIS_MODULE,
+	.start = sony_cronos_wdt_start,
+	.stop = sony_cronos_wdt_stop,
+	.ping = sony_cronos_wdt_ping,
+	.set_timeout = sony_cronos_wdt_set_timeout,
+	.restart = sony_cronos_wdt_restart,
+};
+
+static const struct of_device_id sony_cronos_compatible_id_table[] = {
+	{
+		.compatible = "sony,cronos-watchdog",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sony_cronos_compatible_id_table);
+
+static int sony_cronos_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	unsigned int timeout;
+	struct sony_cronos_smc *chip;
+	struct sony_cronos_watchdog *wdt;
+
+	chip = dev_get_drvdata(dev->parent);
+	if (!chip)
+		return -EINVAL;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->hw = chip;
+
+	wdt->wdtdev.info = &sony_cronos_watchdog_info;
+	wdt->wdtdev.ops = &sony_cronos_watchdog_ops;
+	wdt->wdtdev.min_timeout = CRONOS_WDT_MIN_TIMEOUT;
+	wdt->wdtdev.max_timeout = CRONOS_WDT_MAX_TIMEOUT;
+	wdt->wdtdev.min_hw_heartbeat_ms = 0;
+	wdt->wdtdev.timeout = CRONOS_WDG_DEFAULT_TIMEOUT;
+	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+	wdt->wdtdev.parent = dev;
+
+	watchdog_set_restart_priority(&wdt->wdtdev, 128);
+
+	watchdog_set_drvdata(&wdt->wdtdev, wdt);
+	dev_set_drvdata(dev, &wdt->wdtdev);
+
+	timeout = sony_cronos_wdt_read_timeout(wdt);
+	if (timeout)
+		wdt->wdtdev.timeout = timeout;
+
+	/* Set timeout from DT value if available */
+	watchdog_init_timeout(&wdt->wdtdev, 0, dev->parent);
+
+	if (timeout) {
+		sony_cronos_wdt_set_timeout(&wdt->wdtdev, wdt->wdtdev.timeout);
+		set_bit(WDOG_HW_RUNNING, &wdt->wdtdev.status);
+	}
+
+	return devm_watchdog_register_device(dev, &wdt->wdtdev);
+}
+
+static int __maybe_unused sony_cronos_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	if (watchdog_active(wdd))
+		return sony_cronos_wdt_stop(wdd);
+
+	return 0;
+}
+
+static int __maybe_unused sony_cronos_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	if (watchdog_active(wdd))
+		return sony_cronos_wdt_start(wdd);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(sony_cronos_wdt_pm_ops, sony_cronos_wdt_suspend, sony_cronos_wdt_resume);
+
+static struct platform_driver sony_cronos_wdt_driver = {
+	.probe = sony_cronos_wdt_probe,
+	.driver = {
+		.name = "sony-cronos-watchdog",
+		.pm = &sony_cronos_wdt_pm_ops,
+		.of_match_table = sony_cronos_compatible_id_table,
+	},
+};
+module_platform_driver(sony_cronos_wdt_driver);
+
+MODULE_AUTHOR("Raptor Engineering, LLC <tpearson@raptorengineering.com>");
+MODULE_DESCRIPTION("WDT device driver for Sony Cronos SMCs");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sony-cronos-watchdog");
-- 
2.39.5

