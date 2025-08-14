Return-Path: <linux-kernel+bounces-768391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB239B260A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333035A58D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CDA2EA739;
	Thu, 14 Aug 2025 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6OYOWcP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FA2EA14F;
	Thu, 14 Aug 2025 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162785; cv=none; b=mGZlH9Kne9wfvTmGtW5pW0sEei81srwghvQUbM9jcMGM5aHH0zyihRA2TdqR6EqW0aV8tPtoPvpfjFOBYDQ9kR85l/WuzcnjEqYCjg8VBbYrK81CHil6Rcy5ggdiN0sPpSHUUSaLCM0Qn2ilCVIedpfECNsEzOxWpwB8TfwqtRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162785; c=relaxed/simple;
	bh=q9LD0gI3IQlorPkwhPUPSS6YvP6vOk6wY3/rSaYBFrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuELW8vQjHvOQlmIOfj0koZA/FmHrPyzV0MjynzSKc5yICrWGu+HIUisLgS+iRJ/jU9OXNoQ7k1AuHoZtKNI8Ri/mVFpkiv71iyPlPc5Huf27uIxMsGrX349zXmg2QHmrRkRHjBmP3XGVyWoF4dtBDq/NbXGIPgXnf0CTkq4liQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6OYOWcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B05C4CEEF;
	Thu, 14 Aug 2025 09:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162784;
	bh=q9LD0gI3IQlorPkwhPUPSS6YvP6vOk6wY3/rSaYBFrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6OYOWcPmO8UYvNy7ppr9hGdmmNx6dNBeuB+AQcxn1Tw6e8AYDFm2UItO1/hHVG8c
	 ierr71Gsc/9PGCQ6+SwvI+Bs/ceICdDsvPCoxvLQLiXEcVatbPKsoBgUk/UdwGwaUT
	 D9B0LpbSH1BCi5b3VF4q6SpaK9Ee3tl2ca+JENSjs/wBzEkE848sYHm6FVxuJVk4WU
	 HKqxt3QJ3ZxA3RVZoSDj6zbCZ2hq7JybFoS/vBxGalGiiJLf2xpDEP38l7gHMoRasM
	 KfSnDvDNQDg8LZ3J0/8ZssduLXIKFIzBo80qskto6smgVUGzllOsbvBvBvKW6xpda6
	 keWpdM41dpALQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org
Cc: tzungbi@kernel.org,
	dawidn@google.com,
	chrome-platform@lists.linux.dev,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/chrome: Protect cros_ec_device lifecycle with ref_proxy
Date: Thu, 14 Aug 2025 09:10:19 +0000
Message-ID: <20250814091020.1302888-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250814091020.1302888-1-tzungbi@kernel.org>
References: <20250814091020.1302888-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros_ec_device can be unregistered when the underlying device is
removed.  Other kernel drivers that interact with the EC may hold a
pointer to the cros_ec_device, creating a risk of a use-after-free
error if the EC device is removed while still being referenced.

To prevent this, leverage the ref_proxy library and convert the
underlying device drivers to resource providers of cros_ec_device.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/Kconfig             | 8 ++++++--
 drivers/platform/chrome/cros_ec_i2c.c       | 5 +++++
 drivers/platform/chrome/cros_ec_ishtp.c     | 5 +++++
 drivers/platform/chrome/cros_ec_lpc.c       | 5 +++++
 drivers/platform/chrome/cros_ec_rpmsg.c     | 5 +++++
 drivers/platform/chrome/cros_ec_spi.c       | 4 ++++
 drivers/platform/chrome/cros_ec_uart.c      | 5 +++++
 include/linux/platform_data/cros_ec_proto.h | 3 +++
 8 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 2281d6dacc9b..fe7b219093e9 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -88,7 +88,7 @@ config CROS_EC
 config CROS_EC_I2C
 	tristate "ChromeOS Embedded Controller (I2C)"
 	depends on CROS_EC && I2C
-
+	select REF_PROXY
 	help
 	  If you say Y here, you get support for talking to the ChromeOS
 	  EC through an I2C bus. This uses a simple byte-level protocol with
@@ -98,6 +98,7 @@ config CROS_EC_I2C
 config CROS_EC_RPMSG
 	tristate "ChromeOS Embedded Controller (rpmsg)"
 	depends on CROS_EC && RPMSG && OF
+	select REF_PROXY
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  through rpmsg. This uses a simple byte-level protocol with a
@@ -111,6 +112,7 @@ config CROS_EC_ISHTP
 	tristate "ChromeOS Embedded Controller (ISHTP)"
 	depends on CROS_EC
 	depends on INTEL_ISH_HID
+	select REF_PROXY
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  firmware running on Intel Integrated Sensor Hub (ISH), using the
@@ -123,7 +125,7 @@ config CROS_EC_ISHTP
 config CROS_EC_SPI
 	tristate "ChromeOS Embedded Controller (SPI)"
 	depends on CROS_EC && SPI
-
+	select REF_PROXY
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  through a SPI bus, using a byte-level protocol. Since the EC's
@@ -133,6 +135,7 @@ config CROS_EC_SPI
 config CROS_EC_UART
 	tristate "ChromeOS Embedded Controller (UART)"
 	depends on CROS_EC && ACPI && SERIAL_DEV_BUS
+	select REF_PROXY
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  through a UART, using a byte-level protocol.
@@ -144,6 +147,7 @@ config CROS_EC_LPC
 	tristate "ChromeOS Embedded Controller (LPC)"
 	depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
 	depends on HAS_IOPORT
+	select REF_PROXY
 	help
 	  If you say Y here, you get support for talking to the ChromeOS EC
 	  over an LPC bus, including the LPC Microchip EC (MEC) variant.
diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index 38af97cdaab2..d9ecf27585f1 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -12,6 +12,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/ref_proxy.h>
 #include <linux/slab.h>
 
 #include "cros_ec.h"
@@ -296,6 +297,10 @@ static int cros_ec_i2c_probe(struct i2c_client *client)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->ref_proxy_provider = devm_ref_proxy_provider_alloc(dev, ec_dev);
+	if (!ec_dev->ref_proxy_provider)
+		return -ENOMEM;
+
 	i2c_set_clientdata(client, ec_dev);
 	ec_dev->dev = dev;
 	ec_dev->priv = client;
diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 7e7190b30cbb..0b74a5b16b52 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/ref_proxy.h>
 #include <linux/intel-ish-client-if.h>
 
 #include "cros_ec.h"
@@ -547,6 +548,10 @@ static int cros_ec_dev_init(struct ishtp_cl_data *client_data)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->ref_proxy_provider = devm_ref_proxy_provider_alloc(dev, ec_dev);
+	if (!ec_dev->ref_proxy_provider)
+		return -ENOMEM;
+
 	client_data->ec_dev = ec_dev;
 	dev->driver_data = ec_dev;
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 7d9a78289c96..8b5de1ad5f2f 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/reboot.h>
+#include <linux/ref_proxy.h>
 #include <linux/suspend.h>
 
 #include "cros_ec.h"
@@ -641,6 +642,10 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->ref_proxy_provider = devm_ref_proxy_provider_alloc(dev, ec_dev);
+	if (!ec_dev->ref_proxy_provider)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, ec_dev);
 	ec_dev->dev = dev;
 	ec_dev->phys_name = dev_name(dev);
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
index bc2666491db1..c9be9ba63ead 100644
--- a/drivers/platform/chrome/cros_ec_rpmsg.c
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -10,6 +10,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/ref_proxy.h>
 #include <linux/rpmsg.h>
 #include <linux/slab.h>
 
@@ -220,6 +221,10 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->ref_proxy_provider = devm_ref_proxy_provider_alloc(dev, ec_dev);
+	if (!ec_dev->ref_proxy_provider)
+		return -ENOMEM;
+
 	ec_rpmsg = devm_kzalloc(dev, sizeof(*ec_rpmsg), GFP_KERNEL);
 	if (!ec_rpmsg)
 		return -ENOMEM;
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 8ca0f854e7ac..b0f33f02ec24 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -10,6 +10,7 @@
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
+#include <linux/ref_proxy.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <uapi/linux/sched/types.h>
@@ -752,6 +753,9 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
 	if (!ec_dev)
 		return -ENOMEM;
+	ec_dev->ref_proxy_provider = devm_ref_proxy_provider_alloc(dev, ec_dev);
+	if (!ec_dev->ref_proxy_provider)
+		return -ENOMEM;
 
 	/* Check for any DT properties */
 	cros_ec_spi_dt_probe(ec_spi, dev);
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
index 19c179d49c90..ce080b464977 100644
--- a/drivers/platform/chrome/cros_ec_uart.c
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/ref_proxy.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 #include <uapi/linux/sched/types.h>
@@ -263,6 +264,10 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
 	if (!ec_dev)
 		return -ENOMEM;
 
+	ec_dev->ref_proxy_provider = devm_ref_proxy_provider_alloc(dev, ec_dev);
+	if (!ec_dev->ref_proxy_provider)
+		return -ENOMEM;
+
 	serdev_device_set_drvdata(serdev, ec_dev);
 	init_waitqueue_head(&ec_uart->response.wait_queue);
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 3ec24f445c29..9f5c8fb353b6 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -158,6 +158,7 @@ struct cros_ec_command {
  * @pd: The platform_device used by the mfd driver to interface with the
  *      PD behind an EC.
  * @panic_notifier: EC panic notifier.
+ * @ref_proxy_provider: The ref_proxy_provider to this device.
  */
 struct cros_ec_device {
 	/* These are used by other drivers that want to talk to the EC */
@@ -203,6 +204,8 @@ struct cros_ec_device {
 	struct platform_device *pd;
 
 	struct blocking_notifier_head panic_notifier;
+
+	struct ref_proxy_provider *ref_proxy_provider;
 };
 
 /**
-- 
2.51.0.rc1.163.g2494970778-goog


