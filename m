Return-Path: <linux-kernel+bounces-833021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773A4BA0FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5CB17FDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36612315D26;
	Thu, 25 Sep 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="qMRr8yXp"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD02F49FC;
	Thu, 25 Sep 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824327; cv=none; b=HGai11AjiFek6C9de3NJgvDyZIX4njtI2vUcJLnrLbFVgweG8RghaEBnHPfj/ogNeUVk3di2LMp3NGGaNXzil1MqA4H2UcmgjzpQE5irWW6spQ1gAhkWa713/cO1QL6X/blADoDti7CqoRYBlDIeSIl9Hy0Lo6bunzi/ZXL/6AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824327; c=relaxed/simple;
	bh=WevgtDJgtMzgcrgeNiCS8QLEzaH+Y4Ioo455c9FKI1c=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=LwqbWi3MkTx5G552FjiIiO5E82SiVYAt5veeZ/kHFECHb63HgsahTj0+IAgk6pCd54uVXZu8IpshBXbofga9uaxnuJOmvWNbOEcLYGUUbC16RiKTpbU1OtDkVRx6ahL/iDQU6mOZrBd9qhSLxg0LhyxKThELdaW8BYb7DyFyHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=qMRr8yXp; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8276D828840F;
	Thu, 25 Sep 2025 13:18:44 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id H3tFfhsicpXZ; Thu, 25 Sep 2025 13:18:43 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 30AED8288E19;
	Thu, 25 Sep 2025 13:18:43 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 30AED8288E19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1758824323; bh=zVt8L3kgRRJxb6e/3yTsWsGqVzziUOtwwqn6WwVU5+Y=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=qMRr8yXpEvk56PXpGTML6XJbDTe8F5QSkjg6eUIJjWzJAJrmewfqxH4BhajTLxZ+I
	 sZ5Wq3CCsZb+z7AU5IKl9Kpaj7wNuWjmivhRXgIvIzMO5nW0HLkdQToPs8K+/mkZrz
	 8Zm8w9oueYr6S320sMV9xTXKnMZDsTZZNIXCYPks=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TgSxuj44XYEq; Thu, 25 Sep 2025 13:18:43 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 019C3828840F;
	Thu, 25 Sep 2025 13:18:43 -0500 (CDT)
Date: Thu, 25 Sep 2025 13:18:42 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Cc: Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <140206774.1748567.1758824322906.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v3 4/4] watchdog: sony-cronos-cpld: Add watchdog driver for
 Sony  Cronos CPLD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC139 (Linux)/8.5.0_GA_3042)
Thread-Index: 9j7x+jis1C/M5wOe4CKoSjZllblSrA==
Thread-Topic: watchdog: sony-cronos-cpld: Add watchdog driver for Sony Cronos CPLD

The Sony Cronos Platform Controller CPLD is a multi-purpose platform controller
with an integrated watchdog.  Add the watchdog driver for the Cronos CPLD.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/watchdog/Kconfig           |  17 ++
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/sony-cronos-wdt.c | 302 +++++++++++++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/watchdog/sony-cronos-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0c25b2ed44eb..3acabcafcaae 100644
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
index bbd4d62d2cc3..f29f20a52229 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -242,3 +242,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) += menz69_wdt.o
 obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
 obj-$(CONFIG_STPMIC1_WATCHDOG) += stpmic1_wdt.o
 obj-$(CONFIG_SL28CPLD_WATCHDOG) += sl28cpld_wdt.o
+obj-$(CONFIG_SONY_CRONOS_WATCHDOG) += sony-cronos-wdt.o
diff --git a/drivers/watchdog/sony-cronos-wdt.c b/drivers/watchdog/sony-cronos-wdt.c
new file mode 100644
index 000000000000..6c9c4a7fdf29
--- /dev/null
+++ b/drivers/watchdog/sony-cronos-wdt.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Watchdog device driver for Sony Cronos CPLDs
+ * Copyright (C) 2015 Dialog Semiconductor Ltd.
+ * Copyright (C) 2022-2025 Raptor Engineering, LLC
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/mfd/sony/cronos/registers.h>
+#include <linux/mfd/sony/cronos/core.h>
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
+	struct sony_cronos_cpld *hw;
+	struct watchdog_device wdtdev;
+};
+
+static unsigned int
+sony_cronos_wdt_read_timeout(struct sony_cronos_watchdog *wdt)
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
+	dev_err(wdt->hw->dev,
+		"Invalid configuration data present in watchdog control register!\n");
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
+	return regmap_write(wdt->hw->regmap, CRONOS_WDT_CLR_REG,
+			    CRONOS_WDT_CLR_VAL);
+}
+
+static int
+sony_cronos_wdt_update_timeout_register(struct sony_cronos_watchdog *wdt,
+					unsigned int regval)
+{
+	int ret;
+
+	struct sony_cronos_cpld *chip = wdt->hw;
+
+	ret = sony_cronos_reset_watchdog_timer(wdt);
+	if (ret) {
+		dev_err(wdt->hw->dev, "Watchdog failed to reset (err = %d)\n",
+			ret);
+		goto done;
+	}
+
+	return regmap_update_bits(chip->regmap, CRONOS_WDT_CTL_REG,
+				  CRONOS_WDT_TIMEOUT_MASK, regval);
+
+done:
+	return ret;
+}
+
+static int sony_cronos_wdt_start(struct watchdog_device *wdd)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct sony_cronos_cpld *chip = wdt->hw;
+	unsigned int selector;
+	int ret;
+
+	selector = sony_cronos_wdt_timeout_to_sel(wdt->wdtdev.timeout);
+	ret = sony_cronos_wdt_update_timeout_register(wdt, selector);
+	if (ret) {
+		dev_err(wdt->hw->dev,
+			"Watchdog prestart configuration failed (err = %d)\n",
+			ret);
+		goto done;
+	}
+
+	ret = regmap_update_bits(chip->regmap, CRONOS_WDT_CTL_REG,
+				 CRONOS_WDT_ENABLE_MASK, 1);
+
+	if (ret)
+		dev_err(wdt->hw->dev, "Watchdog failed to start (err = %d)\n",
+			ret);
+
+done:
+	return ret;
+}
+
+static int sony_cronos_wdt_stop(struct watchdog_device *wdd)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct sony_cronos_cpld *chip = wdt->hw;
+	int ret;
+
+	ret = regmap_update_bits(chip->regmap, CRONOS_WDT_CTL_REG,
+				 CRONOS_WDT_ENABLE_MASK, 1);
+	if (ret)
+		dev_err(wdt->hw->dev, "Watchdog failed to stop (err = %d)\n",
+			ret);
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
+		dev_err(wdt->hw->dev,
+			"Failed to ping the watchdog (err = %d)\n", ret);
+
+	return ret;
+}
+
+static int sony_cronos_wdt_set_timeout(struct watchdog_device *wdd,
+				       unsigned int timeout)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	unsigned int selector;
+	int ret;
+
+	selector = sony_cronos_wdt_timeout_to_sel(timeout);
+	ret = sony_cronos_wdt_update_timeout_register(wdt, selector);
+	if (ret)
+		dev_err(wdt->hw->dev,
+			"Failed to set watchdog timeout (err = %d)\n", ret);
+	else
+		wdd->timeout = wdt_timeout[selector];
+
+	return ret;
+}
+
+static int sony_cronos_wdt_restart(struct watchdog_device *wdd,
+				   unsigned long action, void *data)
+{
+	struct sony_cronos_watchdog *wdt = watchdog_get_drvdata(wdd);
+	struct i2c_client *client = to_i2c_client(wdt->hw->dev);
+	int ret;
+
+	/* Don't use regmap because it is not atomic safe */
+	ret = i2c_smbus_write_byte_data(client, CRONOS_WDT_CTL_REG,
+					CRONOS_WDT_CTL_RESET_VAL);
+	ret = i2c_smbus_write_byte_data(client, CRONOS_BMC_RESET_REG,
+					CRONOS_BMC_RESET_VAL);
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
+	struct sony_cronos_cpld *chip;
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
+	watchdog_init_timeout(&wdt->wdtdev, 0, dev);
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
+static SIMPLE_DEV_PM_OPS(sony_cronos_wdt_pm_ops, sony_cronos_wdt_suspend,
+			 sony_cronos_wdt_resume);
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
+MODULE_DESCRIPTION("WDT device driver for Sony Cronos CPLDs");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sony-cronos-watchdog");
-- 
2.39.5

