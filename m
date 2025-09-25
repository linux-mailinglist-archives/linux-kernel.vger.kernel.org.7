Return-Path: <linux-kernel+bounces-831486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AF7B9CCDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EAD3BE31A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5A21E50E;
	Thu, 25 Sep 2025 00:05:24 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB84A00
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758723; cv=none; b=lG1g1u7Q2OY5kEgBievBeExMsR5xZL0LkiZLqEUptaVi5kdXIfY/9nS6q4ezdrBY8XNqVF6dBQEq5IVP4llsfK7cdCE9KnZn5TsF6Lx31yq3z6ZhMNuAD8KIdhH17ZcRXQOaZvMKbRXJIT6P6pYLMbZcIi4A50WIWwq7xtCgo4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758723; c=relaxed/simple;
	bh=rBP/NYxfu/d25awHRJ3Nbyo8YDAump+rfvKwOnAKL24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1tPc/eP9hfnNlt5EGw4eNsVGvN7QpntFjngIVKj+CnjJ1fj9pPmUGOedVRf0A1BfejIpKkGRxYnZhvmrt59KNgADEjaK1v4Q3cwmjhhkY0Y8e0Y9zuRwUkRUVYJtEEpfjfJFcqzyiNc1Iw3w7xIofwLEgtXw9KiljX6W5M/6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B920A67EA3;
	Thu, 25 Sep 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D152A1386E;
	Thu, 25 Sep 2025 00:05:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iG3FMD6H1GgdNQAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Thu, 25 Sep 2025 00:05:18 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-hwmon@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH 2/4] hwmon: adc: rp1: Add Raspberry Pi's RP1 ADC driver
Date: Thu, 25 Sep 2025 03:04:14 +0300
Message-ID: <20250925000416.2408457-3-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250925000416.2408457-1-svarbanov@suse.de>
References: <20250925000416.2408457-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt]
X-Rspamd-Queue-Id: B920A67EA3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

A five-input successive-approximation analogue-to-digital converter
with 12-bit (effective number of 9.5 bits) resolution at 500kSPS.
The ADC has four external inputs and one internal temperature sensor.

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
---
 drivers/hwmon/Kconfig   |  10 ++
 drivers/hwmon/Makefile  |   1 +
 drivers/hwmon/rp1-adc.c | 301 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+)
 create mode 100644 drivers/hwmon/rp1-adc.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 9d28fcf7cd2a..2cde8f83d1df 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2629,6 +2629,16 @@ config SENSORS_INTEL_M10_BMC_HWMON
 	  sensors monitor various telemetry data of different components on the
 	  card, e.g. board temperature, FPGA core temperature/voltage/current.
 
+config SENSORS_RP1_ADC
+	tristate "RP1 ADC and temperature sensor driver"
+	depends on MISC_RP1
+	help
+	  The driver provides support for the hardware monitoring of voltage
+	  and temperature sensor of the Raspberry Pi RP1 peripheral chip.
+
+	  The RP1 ADC is used by Raspberry Pi 5 to monitor four analog inputs
+	  and one temperature sensor input.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index cd8bc4752b4d..574e2c22636f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -196,6 +196,7 @@ obj-$(CONFIG_SENSORS_PT5161L)	+= pt5161l.o
 obj-$(CONFIG_SENSORS_PWM_FAN)	+= pwm-fan.o
 obj-$(CONFIG_SENSORS_QNAP_MCU_HWMON)	+= qnap-mcu-hwmon.o
 obj-$(CONFIG_SENSORS_RASPBERRYPI_HWMON)	+= raspberrypi-hwmon.o
+obj-$(CONFIG_SENSORS_RP1_ADC)	+= rp1-adc.o
 obj-$(CONFIG_SENSORS_SBTSI)	+= sbtsi_temp.o
 obj-$(CONFIG_SENSORS_SBRMI)	+= sbrmi.o
 obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
diff --git a/drivers/hwmon/rp1-adc.c b/drivers/hwmon/rp1-adc.c
new file mode 100644
index 000000000000..2487d19c8ee9
--- /dev/null
+++ b/drivers/hwmon/rp1-adc.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for the RP1 ADC and temperature sensor
+ *
+ * Copyright (C) 2023 Raspberry Pi Ltd.
+ * Copyright (c) 2025, SUSE.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regulator/consumer.h>
+
+#define RP1_ADC_CS			0x00
+#define RP1_ADC_RESULT			0x04
+#define RP1_ADC_FCS			0x08
+#define RP1_ADC_FIFO			0x0c
+#define RP1_ADC_DIV			0x10
+#define RP1_ADC_INTR			0x14
+#define RP1_ADC_INTE			0x18
+#define RP1_ADC_INTF			0x1c
+#define RP1_ADC_INTS			0x20
+
+#define RP1_ADC_RWTYPE_SET		0x2000
+#define RP1_ADC_RWTYPE_CLR		0x3000
+
+#define RP1_ADC_CS_RROBIN_MASK		0x1f
+#define RP1_ADC_CS_RROBIN_SHIFT		16
+#define RP1_ADC_CS_AINSEL_MASK		0x7
+#define RP1_ADC_CS_AINSEL_SHIFT		12
+#define RP1_ADC_CS_ERR_STICKY		0x400
+#define RP1_ADC_CS_ERR			0x200
+#define RP1_ADC_CS_READY		0x100
+#define RP1_ADC_CS_START_MANY		0x8
+#define RP1_ADC_CS_START_ONCE		0x4
+#define RP1_ADC_CS_TS_EN		0x2
+#define RP1_ADC_CS_EN			0x1
+
+#define RP1_ADC_FCS_THRESH_MASK		0xf
+#define RP1_ADC_FCS_THRESH_SHIFT	24
+#define RP1_ADC_FCS_LEVEL_MASK		0xf
+#define RP1_ADC_FCS_LEVEL_SHIFT		16
+#define RP1_ADC_FCS_OVER		0x800
+#define RP1_ADC_FCS_UNDER		0x400
+#define RP1_ADC_FCS_FULL		0x200
+#define RP1_ADC_FCS_EMPTY		0x100
+#define RP1_ADC_FCS_DREQ_EN		0x8
+#define RP1_ADC_FCS_ERR			0x4
+#define RP1_ADC_FCS_SHIFR		0x2
+#define RP1_ADC_FCS_EN			0x1
+
+#define RP1_ADC_FIFO_ERR		0x8000
+#define RP1_ADC_FIFO_VAL_MASK		0xfff
+
+#define RP1_ADC_DIV_INT_MASK		0xffff
+#define RP1_ADC_DIV_INT_SHIFT		8
+#define RP1_ADC_DIV_FRAC_MASK		0xff
+#define RP1_ADC_DIV_FRAC_SHIFT		0
+
+#define RP1_ADC_TEMP_CHAN		4
+
+struct rp1_adc_data {
+	void __iomem		*base;
+	struct mutex		lock;
+	struct device		*hwmon;
+	int			vref_mv;
+	struct clk		*clk;
+	struct regulator	*reg;
+};
+
+static int rp1_adc_read(struct rp1_adc_data *rp1, int channel, long *val)
+{
+	u32 regval;
+	int ret;
+
+	writel(RP1_ADC_CS_AINSEL_MASK << RP1_ADC_CS_AINSEL_SHIFT,
+	       rp1->base + RP1_ADC_RWTYPE_CLR + RP1_ADC_CS);
+	writel(channel << RP1_ADC_CS_AINSEL_SHIFT,
+	       rp1->base + RP1_ADC_RWTYPE_SET + RP1_ADC_CS);
+	writel(RP1_ADC_CS_START_ONCE,
+	       rp1->base + RP1_ADC_RWTYPE_SET + RP1_ADC_CS);
+
+	ret = readl_poll_timeout(rp1->base + RP1_ADC_CS, regval,
+				 regval & RP1_ADC_CS_READY, 10, 1000);
+	if (ret)
+		return ret;
+
+	/* Asserted if the completed conversion had a convergence error */
+	if (readl(rp1->base + RP1_ADC_CS) & RP1_ADC_CS_ERR)
+		return -EIO;
+
+	*val = readl(rp1->base + RP1_ADC_RESULT);
+
+	return 0;
+}
+
+static int rp1_adc_read_temp(struct rp1_adc_data *rp1, long *val)
+{
+	int ret, mv;
+
+	writel(RP1_ADC_CS_TS_EN, rp1->base + RP1_ADC_RWTYPE_SET + RP1_ADC_CS);
+
+	ret = rp1_adc_read(rp1, RP1_ADC_TEMP_CHAN, val);
+	if (ret)
+		return ret;
+
+	mv = ((u64)rp1->vref_mv * *val) / 4095;
+
+	/* T = 27 - (ADC_voltage - 0.706)/0.001721 */
+	*val = 27000 - DIV_ROUND_CLOSEST((mv - 706) * (s64)1000000, 1721);
+
+	return 0;
+}
+
+static umode_t rp1_adc_hwmon_is_visible(const void *drvdata,
+					enum hwmon_sensor_types type,
+					u32 attr, int channel)
+{
+	return 0444;
+}
+
+static int rp1_adc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct rp1_adc_data *rp1 = dev_get_drvdata(dev);
+	int ret = -EOPNOTSUPP;
+
+	mutex_lock(&rp1->lock);
+
+	if (type == hwmon_temp && attr == hwmon_temp_input)
+		ret = rp1_adc_read_temp(rp1, val);
+	else if (type == hwmon_in && attr == hwmon_in_input)
+		ret = rp1_adc_read(rp1, channel, val);
+
+	mutex_unlock(&rp1->lock);
+
+	return ret;
+}
+
+static const char *const rp1_adc_hwmon_in_labels[] = {
+	"ain0", "ain1", "ain2", "ain3",
+};
+
+static const char *const rp1_adc_hwmon_temp_label = {
+	"RP1 die temp"
+};
+
+static int rp1_adc_hwmon_read_string(struct device *dev,
+				     enum hwmon_sensor_types type, u32 attr,
+				     int channel, const char **str)
+{
+	if (type == hwmon_temp && attr == hwmon_temp_label) {
+		*str = rp1_adc_hwmon_temp_label;
+	} else if (type == hwmon_in && attr == hwmon_in_label) {
+		if (channel < ARRAY_SIZE(rp1_adc_hwmon_in_labels))
+			*str = rp1_adc_hwmon_in_labels[channel];
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops rp1_adc_hwmon_ops = {
+	.is_visible	= rp1_adc_hwmon_is_visible,
+	.read		= rp1_adc_hwmon_read,
+	.read_string	= rp1_adc_hwmon_read_string,
+};
+
+static const struct hwmon_channel_info * const rp1_adc_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(in, HWMON_I_INPUT | HWMON_I_LABEL,
+			       HWMON_I_INPUT | HWMON_I_LABEL,
+			       HWMON_I_INPUT | HWMON_I_LABEL,
+			       HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_chip_info rp1_adc_chip_info = {
+	.ops	= &rp1_adc_hwmon_ops,
+	.info	= rp1_adc_hwmon_info,
+};
+
+static int rp1_adc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rp1_adc_data *rp1;
+	int ret;
+
+	rp1 = devm_kzalloc(dev, sizeof(*rp1), GFP_KERNEL);
+	if (!rp1)
+		return -ENOMEM;
+
+	rp1->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rp1->base))
+		return dev_err_probe(dev, PTR_ERR(rp1->base), "can't ioremap resource\n");
+
+	rp1->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(rp1->clk))
+		return dev_err_probe(dev, PTR_ERR(rp1->clk), "can't get clock\n");
+
+	rp1->reg = devm_regulator_get(dev, "vref");
+	if (IS_ERR(rp1->reg))
+		return dev_err_probe(dev, PTR_ERR(rp1->reg), "can't get regulator\n");
+
+	ret = devm_mutex_init(dev, &rp1->lock);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(rp1->clk, 50000000);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(rp1->clk);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, rp1);
+
+	ret = regulator_get_voltage(rp1->reg);
+	if (ret < 0)
+		return ret;
+
+	rp1->vref_mv = DIV_ROUND_CLOSEST(ret, 1000);
+
+	ret = regulator_enable(rp1->reg);
+	if (ret)
+		return ret;
+
+	rp1->hwmon = devm_hwmon_device_register_with_info(dev, "rp1_adc", rp1,
+							  &rp1_adc_chip_info, NULL);
+	if (IS_ERR(rp1->hwmon))
+		return PTR_ERR(rp1->hwmon);
+
+	/* Disable interrupts */
+	writel(0, rp1->base + RP1_ADC_INTE);
+
+	/* Enable the block, clearing any sticky error */
+	writel(RP1_ADC_CS_EN | RP1_ADC_CS_ERR_STICKY, rp1->base + RP1_ADC_CS);
+
+	return 0;
+}
+
+static void rp1_adc_remove(struct platform_device *pdev)
+{
+	struct rp1_adc_data *rp1 = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(rp1->clk);
+	regulator_disable(rp1->reg);
+}
+
+static int rp1_adc_suspend(struct device *dev)
+{
+	struct rp1_adc_data *rp1 = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(rp1->clk);
+	return regulator_disable(rp1->reg);
+}
+
+static int rp1_adc_resume(struct device *dev)
+{
+	struct rp1_adc_data *rp1 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_enable(rp1->reg);
+	if (ret)
+		return ret;
+
+	return clk_prepare_enable(rp1->clk);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(rp1_adc_pm_ops, rp1_adc_suspend, rp1_adc_resume);
+
+static const struct of_device_id rp1_adc_match_table[] = {
+	{ .compatible = "raspberrypi,rp1-adc", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rp1_adc_match_table);
+
+static struct platform_driver rp1_adc_driver = {
+	.probe = rp1_adc_probe,
+	.remove = rp1_adc_remove,
+	.driver = {
+		.name = "rp1-adc",
+		.of_match_table = rp1_adc_match_table,
+		.pm = pm_ptr(&rp1_adc_pm_ops),
+	},
+};
+module_platform_driver(rp1_adc_driver);
+
+MODULE_DESCRIPTION("RP1 ADC driver");
+MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
+MODULE_AUTHOR("Stanimir Varbanov <svarbanov@suse.de>");
+MODULE_LICENSE("GPL");
-- 
2.47.0


