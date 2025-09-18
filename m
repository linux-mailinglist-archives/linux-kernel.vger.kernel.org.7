Return-Path: <linux-kernel+bounces-819776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3A9B7C78F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0217ABA37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7656613FD86;
	Wed, 17 Sep 2025 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HK6Vh37s"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834D11401B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068217; cv=none; b=jTUyZIms2tOLUB9QSx2j65HEqoBpuDwFJ/Tipmq4ZW9TSa5Hx7RmBHUUU/BCjtEGpI4feym5DA1F49kHioiuNz8n6ASZhwMZ4LwRhiiuEG14G12SSyRGnX9GFYB5C36Yqu4Z8Cl93gNw5AwJAvKYdfFHuf4TD363p1JHoklbBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068217; c=relaxed/simple;
	bh=VFsse17th7qJEmbQTNcNe4dQ3KjrrPL7JRM5fTJ1HGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KERm+cJbqK9dVWoaxuYDuV+OoVLPSPAsUkGYtYzb0Sav+f4HkysizcD+mClVA2xjzG1uaaALl4sMuYEtYBysx0zwLFKNA4ybEZfadwQP36nNShupP3nDUS6eIol5oFGu+rZkhyvLqet9IeI/slcPBnu48/Debf+Gvmk4MooBl4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HK6Vh37s; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-265f97930baso4623545ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758068214; x=1758673014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o5QoitmnoAKSIZoVZT9I3vTDCIlFVC03RN2AmrzORrA=;
        b=HK6Vh37sa4THO2lIESV+Re2Ha+ANdtCwmH8UB4yCc1aqkFDCLNGqjAprUKsc4I/Iu/
         +0421OEbJoclrJqEk51f6gGgukvC/cmsJUUXa0lK/tVEjq14QidS2PTajwkMmZsBM7/u
         MjczecXoivHw0uk/3e+oIld/mOCQ4EbSJVuS7ALUMZ4rAv1aXH7cifIEjVXy4vVz7s8G
         Yo79Bd2GEaAjo8B0qMicV9NYS65WBo/wgNWzjSdfwSzYUrpDb14ZywgZBm1312aMh77B
         UQjAZIoCI7inIBn/qA9ku5Zk6GmUu+RsWr9y7siX/2J/DXH1ndm5vDZ+dfPPXW0nkywu
         U45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758068214; x=1758673014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o5QoitmnoAKSIZoVZT9I3vTDCIlFVC03RN2AmrzORrA=;
        b=qJfZJhHO/GYaUQVveKtQtQw6q0it5LFfxyepn0vzO3z6i6ufxWjrapiAw0RCRwAig6
         bS4zdWW2gFm8aM1PihrWk1kAS4FKM1ONd4UaSvf/dlIKBeVK9I7ZmZm/a9Y9DYQE/Ut3
         CB6xMj5TNf419sN+kTBqXnCSt2CeJ1vUbvEy5gw/RQECiZnePsOI1+d1g/j02Dnz+JtP
         GmjtM9qa1svd31y8uSYF/iNA72aIAk9EKAx/lXeuUX/HaN8Ambq/ffq78ws3oDfSGwsz
         5ZHasy+fFR/IanEJFQGNzpu1vlX6/HB5DqjqaZt0W149EAEZaEtamKOY2KvRuTwl68NR
         zQew==
X-Forwarded-Encrypted: i=1; AJvYcCUID1BolWYseWPBNXDBgS52Qxt4zIUYiVWQnxsRLuUNICCVpbNJSXu8SnJYQ02YmRXw24xS5OnlyfK4dSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnalh7vlSrc6j6dnOb6o/uqLQdnpsjc9QTG5RKjqsXwU5gVAe
	WQXZD4z7KmwHl5gJTnwyjXaotR1VCFGr4nceFVYJtHpvAKhMjkqgrOitpYTyA/KDKxs=
X-Gm-Gg: ASbGncvQotQR4pC8ga2BUVZtxOWSrYQbRM262dDee4whOzG1pub/v3mWf52umRdYMn2
	pEiYzRxQ7TsOBODuINnOPbmUeyYwVPzgt8HgNhzYWANURueyzM72cWqpZYEp70xZEuXvftWuyGW
	ZlAuOklD5QU2PkL0kNCKjgqnWn9o9AZEseVbIYk7vRYd42+jRJpTkZxTL2S3Pq4WzC1z2VZJ7GX
	fevCzihNadDD8xz2yALbixoVCZYDRgIniT2YMAd1yvySONLQDz5VTo59F1OAvsSZ/pPfvJGqzIf
	jruI/o1JWaItqZoypE60v41ysKXMMaRcyfEkzQX9vQWi8A3M9qrK6SA2nVa420BZZbDhzcAl+v3
	aHeFdtJo7MVQeULmE13LwhV6QU3VjH1w=
X-Google-Smtp-Source: AGHT+IGe4MkFzN8p3CO2uUb2z9PVNTSkhPQMq0DxSBa1dcRCis7Maoi7iXp24+2MOjTok2/TlKRypQ==
X-Received: by 2002:a17:902:d2c8:b0:266:120a:29cc with SMTP id d9443c01a7336-26812178365mr1084965ad.3.1758068213814;
        Tue, 16 Sep 2025 17:16:53 -0700 (PDT)
Received: from kuoka.. ([218.51.42.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36dc461sm15042425a12.23.2025.09.16.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:16:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Praveen Talari <quic_ptalari@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH] serial: qcom-geni: Fix blocked task
Date: Wed, 17 Sep 2025 09:16:46 +0900
Message-ID: <20250917001645.19263-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert commit 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p
Qualcomm platforms") and its dependent commit 1afa70632c39 ("serial:
qcom-geni: Enable PM runtime for serial driver") because the first one
causes regression - hang task on Qualcomm RB1 board (QRB2210) and unable
to use serial at all during normal boot:

  INFO: task kworker/u16:0:12 blocked for more than 42 seconds.
        Not tainted 6.17.0-rc1-00004-g53e760d89498 #9
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/u16:0   state:D stack:0     pid:12    tgid:12    ppid:2      task_flags:0x4208060 flags:0x00000010
  Workqueue: async async_run_entry_fn
  Call trace:
   __switch_to+0xe8/0x1a0 (T)
   __schedule+0x290/0x7c0
   schedule+0x34/0x118
   rpm_resume+0x14c/0x66c
   rpm_resume+0x2a4/0x66c
   rpm_resume+0x2a4/0x66c
   rpm_resume+0x2a4/0x66c
   __pm_runtime_resume+0x50/0x9c
   __driver_probe_device+0x58/0x120
   driver_probe_device+0x3c/0x154
   __driver_attach_async_helper+0x4c/0xc0
   async_run_entry_fn+0x34/0xe0
   process_one_work+0x148/0x290
   worker_thread+0x2c4/0x3e0
   kthread+0x118/0x1c0
   ret_from_fork+0x10/0x20

The issue was reported on 12th of August and was ignored by author of
commits introducing issue for two weeks.  Only after complaining author
produced a fix which did not work, so if original commits cannot be
reliably fixed for 5 weeks, they obviously are buggy and need to be
dropped.

Fixes: 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms")
Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Closes: https://lore.kernel.org/all/DC0D53ZTNOBU.E8LSD5E5Z8TX@linaro.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 176 +++-----------------------
 1 file changed, 16 insertions(+), 160 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0fdda3a1e70b..7c5befe5490d 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -14,7 +14,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -102,16 +101,10 @@
 #define DMA_RX_BUF_SIZE		2048
 
 static DEFINE_IDA(port_ida);
-#define DOMAIN_IDX_POWER	0
-#define DOMAIN_IDX_PERF		1
 
 struct qcom_geni_device_data {
 	bool console;
 	enum geni_se_xfer_mode mode;
-	struct dev_pm_domain_attach_data pd_data;
-	int (*resources_init)(struct uart_port *uport);
-	int (*set_rate)(struct uart_port *uport, unsigned int baud);
-	int (*power_state)(struct uart_port *uport, bool state);
 };
 
 struct qcom_geni_private_data {
@@ -149,7 +142,6 @@ struct qcom_geni_serial_port {
 
 	struct qcom_geni_private_data private_data;
 	const struct qcom_geni_device_data *dev_data;
-	struct dev_pm_domain_list *pd_list;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -1301,42 +1293,6 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 	return 0;
 }
 
-static int geni_serial_set_level(struct uart_port *uport, unsigned int baud)
-{
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	struct device *perf_dev = port->pd_list->pd_devs[DOMAIN_IDX_PERF];
-
-	/*
-	 * The performance protocol sets UART communication
-	 * speeds by selecting different performance levels
-	 * through the OPP framework.
-	 *
-	 * Supported perf levels for baudrates in firmware are below
-	 * +---------------------+--------------------+
-	 * |  Perf level value   |  Baudrate values   |
-	 * +---------------------+--------------------+
-	 * |      300            |      300           |
-	 * |      1200           |      1200          |
-	 * |      2400           |      2400          |
-	 * |      4800           |      4800          |
-	 * |      9600           |      9600          |
-	 * |      19200          |      19200         |
-	 * |      38400          |      38400         |
-	 * |      57600          |      57600         |
-	 * |      115200         |      115200        |
-	 * |      230400         |      230400        |
-	 * |      460800         |      460800        |
-	 * |      921600         |      921600        |
-	 * |      2000000        |      2000000       |
-	 * |      3000000        |      3000000       |
-	 * |      3200000        |      3200000       |
-	 * |      4000000        |      4000000       |
-	 * +---------------------+--------------------+
-	 */
-
-	return dev_pm_opp_set_level(perf_dev, baud);
-}
-
 static void qcom_geni_serial_set_termios(struct uart_port *uport,
 					 struct ktermios *termios,
 					 const struct ktermios *old)
@@ -1355,7 +1311,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 	/* baud rate */
 	baud = uart_get_baud_rate(uport, termios, old, 300, 8000000);
 
-	ret = port->dev_data->set_rate(uport, baud);
+	ret = geni_serial_set_rate(uport, baud);
 	if (ret)
 		return;
 
@@ -1642,27 +1598,8 @@ static int geni_serial_resources_off(struct uart_port *uport)
 	return 0;
 }
 
-static int geni_serial_resource_state(struct uart_port *uport, bool power_on)
+static int geni_serial_resource_init(struct qcom_geni_serial_port *port)
 {
-	return power_on ? geni_serial_resources_on(uport) : geni_serial_resources_off(uport);
-}
-
-static int geni_serial_pwr_init(struct uart_port *uport)
-{
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
-	int ret;
-
-	ret = dev_pm_domain_attach_list(port->se.dev,
-					&port->dev_data->pd_data, &port->pd_list);
-	if (ret <= 0)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int geni_serial_resource_init(struct uart_port *uport)
-{
-	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	int ret;
 
 	port->se.clk = devm_clk_get(port->se.dev, "se");
@@ -1707,10 +1644,10 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 		old_state = UART_PM_STATE_OFF;
 
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
-		pm_runtime_resume_and_get(uport->dev);
+		geni_serial_resources_on(uport);
 	else if (new_state == UART_PM_STATE_OFF &&
 		 old_state == UART_PM_STATE_ON)
-		pm_runtime_put_sync(uport->dev);
+		geni_serial_resources_off(uport);
 
 }
 
@@ -1813,16 +1750,13 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->se.dev = &pdev->dev;
 	port->se.wrapper = dev_get_drvdata(pdev->dev.parent);
 
-	ret = port->dev_data->resources_init(uport);
+	ret = geni_serial_resource_init(port);
 	if (ret)
 		return ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -EINVAL;
-		goto error;
-	}
-
+	if (!res)
+		return -EINVAL;
 	uport->mapbase = res->start;
 
 	uport->rs485_config = qcom_geni_rs485_config;
@@ -1834,26 +1768,19 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	if (!data->console) {
 		port->rx_buf = devm_kzalloc(uport->dev,
 					    DMA_RX_BUF_SIZE, GFP_KERNEL);
-		if (!port->rx_buf) {
-			ret = -ENOMEM;
-			goto error;
-		}
+		if (!port->rx_buf)
+			return -ENOMEM;
 	}
 
 	port->name = devm_kasprintf(uport->dev, GFP_KERNEL,
 			"qcom_geni_serial_%s%d",
 			uart_console(uport) ? "console" : "uart", uport->line);
-	if (!port->name) {
-		ret = -ENOMEM;
-		goto error;
-	}
+	if (!port->name)
+		return -ENOMEM;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto error;
-	}
-
+	if (irq < 0)
+		return irq;
 	uport->irq = irq;
 	uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE);
 
@@ -1875,18 +1802,16 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			IRQF_TRIGGER_HIGH, port->name, uport);
 	if (ret) {
 		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
-		goto error;
+		return ret;
 	}
 
 	ret = uart_get_rs485_mode(uport);
 	if (ret)
 		return ret;
 
-	devm_pm_runtime_enable(port->se.dev);
-
 	ret = uart_add_one_port(drv, uport);
 	if (ret)
-		goto error;
+		return ret;
 
 	if (port->wakeup_irq > 0) {
 		device_init_wakeup(&pdev->dev, true);
@@ -1896,15 +1821,11 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 			device_init_wakeup(&pdev->dev, false);
 			ida_free(&port_ida, uport->line);
 			uart_remove_one_port(drv, uport);
-			goto error;
+			return ret;
 		}
 	}
 
 	return 0;
-
-error:
-	dev_pm_domain_detach_list(port->pd_list);
-	return ret;
 }
 
 static void qcom_geni_serial_remove(struct platform_device *pdev)
@@ -1917,31 +1838,6 @@ static void qcom_geni_serial_remove(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, false);
 	ida_free(&port_ida, uport->line);
 	uart_remove_one_port(drv, &port->uport);
-	dev_pm_domain_detach_list(port->pd_list);
-}
-
-static int __maybe_unused qcom_geni_serial_runtime_suspend(struct device *dev)
-{
-	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
-	struct uart_port *uport = &port->uport;
-	int ret = 0;
-
-	if (port->dev_data->power_state)
-		ret = port->dev_data->power_state(uport, false);
-
-	return ret;
-}
-
-static int __maybe_unused qcom_geni_serial_runtime_resume(struct device *dev)
-{
-	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
-	struct uart_port *uport = &port->uport;
-	int ret = 0;
-
-	if (port->dev_data->power_state)
-		ret = port->dev_data->power_state(uport, true);
-
-	return ret;
 }
 
 static int qcom_geni_serial_suspend(struct device *dev)
@@ -1979,46 +1875,14 @@ static int qcom_geni_serial_resume(struct device *dev)
 static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
-	.resources_init = geni_serial_resource_init,
-	.set_rate = geni_serial_set_rate,
-	.power_state = geni_serial_resource_state,
 };
 
 static const struct qcom_geni_device_data qcom_geni_uart_data = {
 	.console = false,
 	.mode = GENI_SE_DMA,
-	.resources_init = geni_serial_resource_init,
-	.set_rate = geni_serial_set_rate,
-	.power_state = geni_serial_resource_state,
-};
-
-static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
-	.console = true,
-	.mode = GENI_SE_FIFO,
-	.pd_data = {
-		.pd_flags = PD_FLAG_DEV_LINK_ON,
-		.pd_names = (const char*[]) { "power", "perf" },
-		.num_pd_names = 2,
-	},
-	.resources_init = geni_serial_pwr_init,
-	.set_rate = geni_serial_set_level,
-};
-
-static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {
-	.console = false,
-	.mode = GENI_SE_DMA,
-	.pd_data = {
-		.pd_flags = PD_FLAG_DEV_LINK_ON,
-		.pd_names = (const char*[]) { "power", "perf" },
-		.num_pd_names = 2,
-	},
-	.resources_init = geni_serial_pwr_init,
-	.set_rate = geni_serial_set_level,
 };
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
-	SET_RUNTIME_PM_OPS(qcom_geni_serial_runtime_suspend,
-			   qcom_geni_serial_runtime_resume, NULL)
 	SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_suspend, qcom_geni_serial_resume)
 };
 
@@ -2027,18 +1891,10 @@ static const struct of_device_id qcom_geni_serial_match_table[] = {
 		.compatible = "qcom,geni-debug-uart",
 		.data = &qcom_geni_console_data,
 	},
-	{
-		.compatible = "qcom,sa8255p-geni-debug-uart",
-		.data = &sa8255p_qcom_geni_console_data,
-	},
 	{
 		.compatible = "qcom,geni-uart",
 		.data = &qcom_geni_uart_data,
 	},
-	{
-		.compatible = "qcom,sa8255p-geni-uart",
-		.data = &sa8255p_qcom_geni_uart_data,
-	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_geni_serial_match_table);
-- 
2.48.1


