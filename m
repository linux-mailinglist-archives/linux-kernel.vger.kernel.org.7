Return-Path: <linux-kernel+bounces-807444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886CAB4A46B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD31189CDC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8182224337B;
	Tue,  9 Sep 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AJpyLmNc"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C6241679;
	Tue,  9 Sep 2025 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404871; cv=none; b=oJ+w5jLBiQVlfZav9TM4bHT9bAmP5q+I1CK9m4Iugfr9vcrxxmDgsGv9R14zfqSxhifa7qFxy3baMMZI+w4Pf/QZSxZlD9xHzgJqFuCaRCT29wVKTt8dK8fUWKnc3fL/iYxsX9Zien4k7yRf3pvytVOU37rrEoNSyZXar0wbHM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404871; c=relaxed/simple;
	bh=TYSSALaNN88yDNMuTj3Tkc5e9N/28HGsb5LmnzaLAgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfGgdUNmR9BSLybiGXmh/0Z5Rrm4vc95Z9iL3fOf8TX3jx9NjSLfu2k18xpGXDseRNJfaf1vMO3erdLOqcQ5poliPRg2ndFZCQaI7uYa0VAwsO8oE4NLkuuaoeukKzHVMFrtEWGrjTlSaAtfUaLmCrHEgZ/evDslqIuOo3ckde4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AJpyLmNc; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 589813FZ242028;
	Tue, 9 Sep 2025 03:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757404863;
	bh=lPVLiLWnNh/xkZYErsUzIMHGNvkM4IRvMNYd2WqV4Ac=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AJpyLmNchh4QyapZRdDBTP8DxQrxYBSQQCTJouHYjvW3An2VZ6EjO1TeZFQc+KYzb
	 HkocpTwv3WyG+SgEbHiWwJ9VoHp/fyow5pdvLEJMYpnwNaSnCBiw/qFnS7Newm15xk
	 RMIP3OqRR1J0jgwBIw3ksySnkwP7yJ5puXxUCUXY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 589813lg3626116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 9 Sep 2025 03:01:03 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 03:01:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 03:01:03 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.150])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58980nwe2009791;
	Tue, 9 Sep 2025 03:00:59 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <j-keerthy@ti.com>, <vigneshr@ti.com>, <wbg@kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <g-praveen@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH 2/2] counter: ti-dmtimer-cap : capture driver support for OMAP DM timer
Date: Tue, 9 Sep 2025 13:30:42 +0530
Message-ID: <20250909080042.36127-3-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909080042.36127-1-g-praveen@ti.com>
References: <20250909080042.36127-1-g-praveen@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Enable capture driver support for OMAP DM timer hardware.

DM timer hardware supports capture feature.It can be used
to timestamp events (falling/rising edges) detected on input signal.

The timer IO pin can also be configured in PWM mode but this
driver supports simple independent capture functionality.

It is assumed that the capture signal is active else both duty cycle
and period returned by driver will not be valid.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
BOOT LOGS:
https://gist.github.com/GokulPraveen2001/581fa07b2e93f30dea9f6188a97b944b

TIMER CAPTURE DTSO:

&{/} {

       main_cap10: dmtimer-main-cap-10 {
               compatible = "ti,omap-dmtimer-cap";
               ti,timers = <&main_timer10>;
               pinctrl-0 = <&maindmtimer1_pins_default>,<&main_timer10_ctrl_config>;
               pinctrl-names = "default";
       };

};

&main_timer10{
       status = "okay";
};

/*MAIN_TIMERIO1*/
&main_pmx0 {
    maindmtimer1_pins_default: maindmtimer1-default-pins {
        pinctrl-single,pins = <
            J784S4_IOPAD(0x0ec, PIN_INPUT, 0) /* (AN37) TIMER_IO1:Input mode for Capture*/
        >;
    };

};

/*Sets in CAP mode using MAIN TIMER IOX(X=1 here) CTRL MMR REGISTERS*/
&main_timerio_input {
       main_timer10_ctrl_config: main-timer10-ctrl-config {
               pinctrl-single,pins = <
                       J784S4_IOPAD(0x28,0,0x1)>; /*  MAIN_TIMER_10 will use MAIN_TIMERIO1 pin(maindmtimer1-default-pins) for capture*/
       };
};
---
 drivers/counter/Kconfig          |  13 +
 drivers/counter/Makefile         |   1 +
 drivers/counter/ti-dmtimer-cap.c | 455 +++++++++++++++++++++++++++++++
 3 files changed, 469 insertions(+)
 create mode 100644 drivers/counter/ti-dmtimer-cap.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d30d22dfe577..bec07cf15779 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -121,6 +121,19 @@ config STM32_TIMER_CNT
 	  To compile this driver as a module, choose M here: the
 	  module will be called stm32-timer-cnt.
 
+config TI_DMTIMER_CAPTURE
+	tristate "OMAP Dual-Mode Timer Capture support"
+	depends on OMAP_DM_TIMER || COMPILE_TEST
+	help
+	  Select this option to use the Texas Instruments OMAP DM Timer
+	  driver in capture mode.
+
+	  It can be used to timestamp events (falling/rising edges) detected
+	  on Timer input signal.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ti-dmtimer-cap.
+
 config TI_ECAP_CAPTURE
 	tristate "TI eCAP capture driver"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index fa3c1d08f706..7c2d226fe984 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
 obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
 obj-$(CONFIG_TI_ECAP_CAPTURE)	+= ti-ecap-capture.o
+obj-$(CONFIG_TI_DMTIMER_CAPTURE)	+=ti-dmtimer-cap.o
diff --git a/drivers/counter/ti-dmtimer-cap.c b/drivers/counter/ti-dmtimer-cap.c
new file mode 100644
index 000000000000..dedfb15faa10
--- /dev/null
+++ b/drivers/counter/ti-dmtimer-cap.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DM timer Capture Driver
+ */
+
+#include <clocksource/timer-ti-dm.h>
+#include <linux/atomic.h>
+#include <linux/counter.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_data/dmtimer-omap.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+
+#define TIMER_DRV_NAME "CAP_OMAP_DMTIMER"
+/* Timer signals */
+#define TIMER_CLOCK_SIG 0
+#define TIMER_INPUT_SIG 1
+
+/**
+ * struct cap_omap_dmtimer_counter - Structure representing a cap counter
+ *				  corresponding to omap dm timer.
+ * @counter:		Capture counter
+ * @enabled:		Tracks the enable status of omap dm timer.
+ * @mutex:			Mutex to protect cap apply state
+ * @dm_timer:		Pointer to omap dm timer.
+ * @pdata:			Pointer to omap dm timer ops.
+ * @dm_timer_pdev:	Pointer to omap dm timer platform device
+ */
+struct cap_omap_dmtimer_counter {
+	struct counter_device counter;
+	bool enabled;
+	/* Mutex to protect cap apply state */
+	struct mutex mutex;
+	struct omap_dm_timer *dm_timer;
+	const struct omap_dm_timer_ops *pdata;
+	struct platform_device *dm_timer_pdev;
+};
+/**
+ * cap_omap_dmtimer_start() - Start the cap omap dm timer in capture mode
+ * @omap:	Pointer to cap omap dm timer counter
+ */
+static void cap_omap_dmtimer_start(struct cap_omap_dmtimer_counter *omap)
+{
+	u32 ret;
+	struct device *dev = &omap->dm_timer_pdev->dev;
+
+	ret = omap->pdata->start(omap->dm_timer);
+	if (ret)
+		dev_err(dev, "%d: Failed to start timer.\n", ret);
+}
+
+/**
+ * cap_omap_dmtimer_is_enabled() -  Detect if the timer capture is enabled.
+ * @omap:	Pointer to cap omap dm timer counter
+ *
+ * Return true if capture is enabled else false.
+ */
+static bool cap_omap_dmtimer_is_enabled(struct cap_omap_dmtimer_counter *omap)
+{
+	u32 status;
+
+	status = omap->pdata->get_cap_status(omap->dm_timer);
+
+	return !!(status & OMAP_TIMER_CTRL_ST);
+}
+
+static int cap_omap_dmtimer_clk_get_freq(struct counter_device *counter,
+				 struct counter_signal *signal, u64 *freq)
+{
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+	struct clk *fclk;
+
+	fclk = omap->pdata->get_fclk(omap->dm_timer);
+	if (!fclk) {
+		dev_err(counter->parent, "invalid dmtimer fclk\n");
+		return -EINVAL;
+	}
+
+	*freq = clk_get_rate(fclk);
+	if (!(*freq)) {
+		dev_err(counter->parent, "invalid dmtimer fclk rate\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+/**
+ * cap_omap_dmtimer_apply() - Changes the state of the cap omap dm timer counter.
+ * @counter:Pointer to capture counter.
+ *
+ * Return 0 if successfully changed the state else appropriate error.
+ */
+static int cap_omap_dmtimer_apply(struct counter_device *counter)
+{
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+	struct device *dev = &omap->dm_timer_pdev->dev;
+	int ret = 0;
+
+	/* Ensure that the timer is in stop mode so that the configs can be changed. */
+	if (cap_omap_dmtimer_is_enabled(omap)) {
+		ret = omap->pdata->stop(omap->dm_timer);
+		if (ret)
+			dev_err(dev, "%d: Failed to stop timer.\n", ret);
+	}
+
+	ret = omap->pdata->set_cap(omap->dm_timer, true, true);
+	if (ret) {
+		dev_err(dev, "%d: Failed to set timer capture configuration.\n", ret);
+		return ret;
+	}
+
+	cap_omap_dmtimer_start(omap);
+
+	return ret;
+}
+
+static int cap_omap_dmtimer_capture(struct counter_device *counter,
+					struct counter_count *count, u64 *duty_cycle)
+{
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+	*duty_cycle = 0;
+
+	if (!omap->enabled) {
+		dev_err(counter->parent, "Timer is disabled.\n");
+		omap->pdata->stop(omap->dm_timer);
+		return 0;
+	}
+
+	*duty_cycle = omap->pdata->read_cap(omap->dm_timer, false);
+
+	*duty_cycle = *duty_cycle > 0 ? *duty_cycle : 0;
+
+	return *duty_cycle;
+}
+
+static int cap_omap_dmtimer_period(struct counter_device *counter,
+					struct counter_signal *signal, u64 *freq)
+{
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+	u64 clk_freq = 0;
+	u64 period = 0;
+	*freq = 0;
+
+	if (!omap->enabled) {
+		dev_err(counter->parent, "Timer is disabled.\n");
+		omap->pdata->stop(omap->dm_timer);
+		return 0;
+	}
+
+	period = omap->pdata->read_cap(omap->dm_timer, true);
+	cap_omap_dmtimer_clk_get_freq(counter, signal, &clk_freq);
+
+	if (period > 0)
+		*freq = clk_freq/period;
+
+	return *freq+1;
+}
+static int cap_omap_dmtimer_enable_read(struct counter_device *counter,
+				struct counter_count *count, u8 *enable)
+{
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+
+	*enable = omap->enabled;
+
+	return 0;
+}
+
+static int cap_omap_dmtimer_count_read(struct counter_device *counter,
+			       struct counter_count *count, u64 *val)
+{
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+
+	*val = omap->pdata->read_counter(omap->dm_timer);
+
+	return 0;
+}
+
+static int cap_omap_dmtimer_count_write(struct counter_device *counter,
+				struct counter_count *count, u64 val)
+{
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+
+	if (val > U32_MAX)
+		return -ERANGE;
+
+	omap->pdata->write_counter(omap->dm_timer, val);
+
+	return 0;
+}
+
+static int cap_omap_dmtimer_enable_write(struct counter_device *counter,
+				 struct counter_count *count, u8 enable)
+{
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+
+	if (enable == omap->enabled)
+		goto out;
+
+	if (enable)
+		cap_omap_dmtimer_apply(counter);
+	else
+		omap->pdata->stop(omap->dm_timer);
+
+	omap->enabled = enable;
+out:
+	return 0;
+}
+
+static int cap_omap_dmtimer_function_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  enum counter_function *function)
+{
+	*function = COUNTER_FUNCTION_INCREASE;
+
+	return 0;
+}
+
+static int cap_omap_dmtimer_action_read(struct counter_device *counter,
+				struct counter_count *count,
+				struct counter_synapse *synapse,
+				enum counter_synapse_action *action)
+{
+	*action = (synapse->signal->id == TIMER_CLOCK_SIG) ?
+		   COUNTER_SYNAPSE_ACTION_RISING_EDGE :
+		   COUNTER_SYNAPSE_ACTION_NONE;
+
+	return 0;
+}
+
+static const struct counter_ops cap_omap_dmtimer_ops = {
+	.count_read = cap_omap_dmtimer_count_read,
+	.count_write = cap_omap_dmtimer_count_write,
+	.function_read = cap_omap_dmtimer_function_read,
+	.action_read = cap_omap_dmtimer_action_read,
+};
+
+static const enum counter_function cap_omap_dmtimer_functions[] = {
+	COUNTER_FUNCTION_INCREASE,
+};
+
+static struct counter_comp cap_omap_dmtimer_clock_ext[] = {
+	COUNTER_COMP_SIGNAL_U64("frequency", cap_omap_dmtimer_clk_get_freq, NULL),
+};
+
+static struct counter_signal cap_omap_dmtimer_signals[] = {
+	{
+		.id = TIMER_CLOCK_SIG,
+		.name = "Clock Signal",
+		.ext = cap_omap_dmtimer_clock_ext,
+		.num_ext = ARRAY_SIZE(cap_omap_dmtimer_clock_ext),
+	},
+	{
+		.id = TIMER_INPUT_SIG,
+		.name = "Input Signal",
+	},
+};
+
+/* Counter will increase at rising edges of a clock */
+static const enum counter_synapse_action cap_omap_dmtimer_clock_actions[] = {
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+};
+
+/* No trigger here */
+static const enum counter_synapse_action cap_omap_dmtimer_input_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+};
+
+static struct counter_synapse cap_omap_dmtimer_synapses[] = {
+	{
+		.actions_list = cap_omap_dmtimer_clock_actions,
+		.num_actions = ARRAY_SIZE(cap_omap_dmtimer_clock_actions),
+		.signal = &cap_omap_dmtimer_signals[TIMER_CLOCK_SIG],
+	},
+	{
+		.actions_list = cap_omap_dmtimer_input_actions,
+		.num_actions = ARRAY_SIZE(cap_omap_dmtimer_input_actions),
+		.signal = &cap_omap_dmtimer_signals[TIMER_INPUT_SIG],
+	},
+};
+
+static struct counter_comp cap_omap_dmtimer_count_ext[] = {
+	COUNTER_COMP_CAPTURE(cap_omap_dmtimer_capture, NULL),
+	COUNTER_COMP_ENABLE(cap_omap_dmtimer_enable_read, cap_omap_dmtimer_enable_write),
+	COUNTER_COMP_FREQUENCY(cap_omap_dmtimer_period),
+};
+
+static struct counter_count cap_omap_dmtimer_counts[] = {
+	{
+		.name = "Timestamp Counter",
+		.functions_list = cap_omap_dmtimer_functions,
+		.num_functions = ARRAY_SIZE(cap_omap_dmtimer_functions),
+		.synapses = cap_omap_dmtimer_synapses,
+		.num_synapses = ARRAY_SIZE(cap_omap_dmtimer_synapses),
+		.ext = cap_omap_dmtimer_count_ext,
+		.num_ext = ARRAY_SIZE(cap_omap_dmtimer_count_ext),
+	},
+};
+
+static int cap_omap_dmtimer_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct dmtimer_platform_data *timer_pdata;
+	const struct omap_dm_timer_ops *pdata;
+	struct platform_device *timer_pdev;
+	struct omap_dm_timer *dm_timer;
+	struct device_node *timer;
+	struct cap_omap_dmtimer_counter *omap;
+	struct counter_device *counter_dev;
+	int ret = 0;
+
+	timer = of_parse_phandle(np, "ti,timers", 0);
+	if (!timer) {
+		dev_err(&pdev->dev, "Unable to find Timer node\n");
+		return -ENODEV;
+	}
+
+	timer_pdev = of_find_device_by_node(timer);
+	if (!timer_pdev) {
+		dev_err(&pdev->dev, "Unable to find Timer pdev\n");
+		ret = -ENODEV;
+		goto err_find_timer_pdev;
+	}
+	timer_pdata = dev_get_platdata(&timer_pdev->dev);
+	if (!timer_pdata) {
+		dev_dbg(&pdev->dev,
+			"dmtimer pdata structure NULL, deferring probe\n");
+		ret = -EPROBE_DEFER;
+		dev_err_probe(&pdev->dev, ret, "Probe deferred\n");
+		goto err_platdata;
+	}
+
+	pdata = timer_pdata->timer_ops;
+
+	if (!pdata || !pdata->request_by_node ||
+	    !pdata->free ||
+	    !pdata->enable ||
+	    !pdata->disable ||
+	    !pdata->get_fclk ||
+	    !pdata->start ||
+	    !pdata->stop ||
+	    !pdata->set_load ||
+	    !pdata->set_match ||
+	    !pdata->set_cap ||
+	    !pdata->get_cap_status ||
+		!pdata->read_cap ||
+	    !pdata->set_prescaler ||
+		!pdata->write_counter) {
+		dev_err(&pdev->dev, "Incomplete dmtimer pdata structure\n");
+		ret = -EINVAL;
+		goto err_platdata;
+	}
+
+	dm_timer = pdata->request_by_node(timer);
+	if (!dm_timer) {
+		ret = -EPROBE_DEFER;
+		goto err_request_timer;
+	}
+
+    /* struct cap_omap_dmtimer_counter *omap */
+	counter_dev = devm_counter_alloc(dev, sizeof(*omap));
+	if (!counter_dev) {
+		dev_err(&pdev->dev, "Unable to allocate dmtimercounter\n");
+		ret = -ENOMEM;
+		goto err_alloc_omap;
+	}
+	omap = counter_priv(counter_dev);
+
+	counter_dev->name = TIMER_DRV_NAME;
+	counter_dev->parent = dev;
+	counter_dev->ops = &cap_omap_dmtimer_ops;
+	counter_dev->signals = cap_omap_dmtimer_signals;
+	counter_dev->num_signals = ARRAY_SIZE(cap_omap_dmtimer_signals);
+	counter_dev->counts = cap_omap_dmtimer_counts;
+	counter_dev->num_counts = ARRAY_SIZE(cap_omap_dmtimer_counts);
+	mutex_init(&omap->mutex);
+	omap->pdata = pdata;
+	omap->dm_timer = dm_timer;
+	omap->dm_timer_pdev = timer_pdev;
+
+	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
+		omap->pdata->stop(omap->dm_timer);
+
+	of_node_put(timer);
+
+	platform_set_drvdata(pdev, counter_dev);
+
+	ret = devm_counter_add(dev, counter_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add counter\n");
+
+	return 0;
+
+err_alloc_omap:
+	pdata->free(dm_timer);
+err_request_timer:
+
+err_platdata:
+	put_device(&timer_pdev->dev);
+err_find_timer_pdev:
+
+	of_node_put(timer);
+
+	return ret;
+}
+
+static void cap_omap_dmtimer_remove(struct platform_device *pdev)
+{
+	struct counter_device *counter = platform_get_drvdata(pdev);
+	struct cap_omap_dmtimer_counter *omap = counter_priv(counter);
+
+	counter_unregister(counter);
+
+	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
+		omap->pdata->stop(omap->dm_timer);
+
+	omap->pdata->free(omap->dm_timer);
+
+	put_device(&omap->dm_timer_pdev->dev);
+
+	mutex_destroy(&omap->mutex);
+
+}
+
+static const struct of_device_id cap_omap_dmtimer_of_match[] = {
+	{.compatible = "ti,omap-dmtimer-cap"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cap_omap_dmtimer_of_match);
+
+static struct platform_driver cap_omap_dmtimer_driver = {
+	.driver = {
+		.name = "omap-dmtimer-cap",
+		.of_match_table = cap_omap_dmtimer_of_match,
+	},
+	.probe = cap_omap_dmtimer_probe,
+	.remove = cap_omap_dmtimer_remove,
+};
+module_platform_driver(cap_omap_dmtimer_driver);
+
+MODULE_AUTHOR("Gokul Praveen <g-praveen@ti.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("OMAP CAP Driver using Dual-mode Timers");
+MODULE_IMPORT_NS("COUNTER");
-- 
2.34.1


