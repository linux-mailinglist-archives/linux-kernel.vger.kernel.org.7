Return-Path: <linux-kernel+bounces-624631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF165AA059A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 10:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E331166F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 08:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4D42949F1;
	Tue, 29 Apr 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHOvBL1t"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5082949F4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914936; cv=none; b=VQrCKE6tBXqym1sifYkfMe1CcP58UUZh2W1N3+1e0Dnd7lctX/1seLtzAjF+V/iy8UU440A8TDpN7KDjmHt2817pLcWxsZsNM0Fr6WMD+Gc7LHXkVnodoC3fbLe8XOG4NTww7jfMajSZSV4XwOg/rxWey3GjSf39JzQnbCReSfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914936; c=relaxed/simple;
	bh=qXh1LhaYLkXSWWH/b3QjTmcFi9Y6Mcen5lXF4ti3jus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ol02RjQ0XfqGZCChQJPr19DLtztGwdxDECv78XeNZHHB4f7PxvXQQPs3hg910EwyCtmUDb1TiDmkZBdcrUFsjP7GUAaDeTYjV+JKFUiFjCV8zpvEvBRm4h9aoPq0Cxdms8/PNgI8qEWS9zLTk9ignLg9aqQv/2MbcbYtmZn++Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHOvBL1t; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so824942666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745914930; x=1746519730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f56V+PMS/zh+2CuvUyMs7Dtx3aNokKMlJLq1w/Edaiw=;
        b=KHOvBL1tLAGU+ewZwQH2P2ES4uSJEmmcXGVnodhcit+aJaW2V7TLqe0W37CASytjE8
         7cFOpimni5CTQseJ7mQmyDvkkrVk6QPMByP/T6W/A/gHG2K9+C8psEDdOdUoOuZCRtiX
         45EJr5NEGJAlMszM+E1r5tjg2WKq6p+ukojIAtclg8LZCMtnK/e1k20WfmTlyXkaSpT8
         OemeIgQmCWSRXNMtCiM2TJPThqGGOTuMjd++vwLYY/gE4mGgnUJ29q8aro2P7L2767A9
         K4moAClZwECLuohGbi6qdyjsumqYO8i5rXwr/SWrjTEWn5aIEWlesSDDjU6C6BDbRY+2
         FW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745914930; x=1746519730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f56V+PMS/zh+2CuvUyMs7Dtx3aNokKMlJLq1w/Edaiw=;
        b=WdCU92GAlGD3/cSobnIkrZ2vztOfxFsXnaxx6pRARHwCDape72ZEta3TOPEapQoeCR
         UE/9xd5P1kJasRlTvibxl/dKYpfWTiiHL3FNTbSjncfjFi3wYxftQN+HffyqayFO/hs0
         BimUGmRV4PYos4WK/HKEGKgKCOgcs3DW7SNNd4joxODuNUvc+h3C3AV7BYQ0Bsp3SRNr
         0MOFRkl55Hr12PuXyo39D4oxWJxuM/ngxNavqdcDVV/+dyZjhQnlzDV4K5yf8dcGUe0L
         XBkwOPQsppKd0L7g8FOb/urTCE/yqq8Sds4gW3h5sab8udPISUIT3OP+3wQVJLOC+C/S
         Cm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUowtfrONJbvHO5rPx87psVPfZY3O16dxuh3e2EOf8n/ockf9O8dtSsoMiI+6Zu7d+0xpmAKupIyocirU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5jG5LqkYdS/Rv1DwGU2z9TwAP8/055I0uHzGGtFTaid1ucTD
	Q+u8VElLHxzGbNGWvLl5D2vaSIqis7HYQ0i+4GOk4L3ztvMXmqliQGbM/bYOcWw=
X-Gm-Gg: ASbGncun6u2bEfX7yQ8ptz3gg9ZgcST1OgRbnwGJgIIt2YvC39TBWSnb6IHB3FBkNh/
	rO/1s4hBDe20t+tLTMPHG8x7Ao69wVAK2wtadD6BcfxOTwX89OoNbAvrkDPx9EfVINgSKWg1KfK
	X7AUK6GZMpDT+0FlJ8Dg0Y/QjUm8KHzHws0rtXwPTjByFE0teBczejnCkXGwpXcRka689G8b7Hp
	cSkU6+yOgC1mvyDeGOzUhQ4D7CDiPLmerv9PVUzAd2M8rITwv+2nYc4mF4QJnl6n/5m+RI2bS4r
	a239/yBhJHsvSpCtpIFTZkUH2dDOFexsqN6fDGG1UeiFnFajESqRTABmsiLVA/8MmOHl3rq96gR
	XK6DK1pbPLeUrPCCF2aIRqhbT
X-Google-Smtp-Source: AGHT+IGj8hisvwsc6IDrQZfOJ2kFI+cl+XZ/yhKxkqTWsDCHln82PCyF+lR+RtDEIFXKTgUNw9lP8g==
X-Received: by 2002:a17:907:8688:b0:ace:6a18:595c with SMTP id a640c23a62f3a-acec4b7e233mr195098766b.16.1745914930482;
        Tue, 29 Apr 2025 01:22:10 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbf4sm737905466b.36.2025.04.29.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:22:10 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 29 Apr 2025 09:21:42 +0100
Subject: [PATCH v8 6/6] nvmem: max77759: add Maxim MAX77759 NVMEM driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-max77759-mfd-v8-6-72d72dc79a1f@linaro.org>
References: <20250429-max77759-mfd-v8-0-72d72dc79a1f@linaro.org>
In-Reply-To: <20250429-max77759-mfd-v8-0-72d72dc79a1f@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srini@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This driver exposes the non volatile memory using the platform device
registered by the core MFD driver.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v8:
* replace MODULE_ALIAS() with .id_table (Krzysztof)
* drop previous tags

v5:
* follow API updates of max77759 core driver

v2:
* align sentinel in max77759_nvmem_of_id[] with other max77759 drivers
 (Christophe)
---
 MAINTAINERS                    |   1 +
 drivers/nvmem/Kconfig          |  12 +++
 drivers/nvmem/Makefile         |   2 +
 drivers/nvmem/max77759-nvmem.c | 162 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0db5e1fe64930e85265913e6a7dd2669c645cf42..b821502afc48f95d48fb8c6ac6941d1dd8e63582 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14670,6 +14670,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/*/maxim,max77759*.yaml
 F:	drivers/gpio/gpio-max77759.c
 F:	drivers/mfd/max77759.c
+F:	drivers/nvmem/max77759-nvmem.c
 F:	include/linux/mfd/max77759.h
 
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8671b7c974b933e147154bb40b5d41b5730518d2..3de07ef524906ad24a89e58abdfe93529a83c80f 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -154,6 +154,18 @@ config NVMEM_LPC18XX_OTP
 	  To compile this driver as a module, choose M here: the module
 	  will be called nvmem_lpc18xx_otp.
 
+config NVMEM_MAX77759
+	tristate "Maxim Integrated MAX77759 NVMEM Support"
+	depends on MFD_MAX77759
+	default MFD_MAX77759
+	help
+	  Say Y here to include support for the user-accessible storage found
+	  in Maxim Integrated MAX77759 PMICs. This IC provides space for 30
+	  bytes of storage.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-max77759.
+
 config NVMEM_MESON_EFUSE
 	tristate "Amlogic Meson GX eFuse Support"
 	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 5b77bbb6488bf89bfb305750a1cbf4a6731a0a58..a9d03cfbbd27e68d40f8c330e72e20378b12a481 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -34,6 +34,8 @@ obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
 nvmem_lpc18xx_eeprom-y			:= lpc18xx_eeprom.o
 obj-$(CONFIG_NVMEM_LPC18XX_OTP)		+= nvmem_lpc18xx_otp.o
 nvmem_lpc18xx_otp-y			:= lpc18xx_otp.o
+obj-$(CONFIG_NVMEM_MAX77759)		+= nvmem-max77759.o
+nvmem-max77759-y			:= max77759-nvmem.o
 obj-$(CONFIG_NVMEM_MESON_EFUSE)		+= nvmem_meson_efuse.o
 nvmem_meson_efuse-y			:= meson-efuse.o
 obj-$(CONFIG_NVMEM_MESON_MX_EFUSE)	+= nvmem_meson_mx_efuse.o
diff --git a/drivers/nvmem/max77759-nvmem.c b/drivers/nvmem/max77759-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..df7d1998fa2f116450d2fd50eba70d9b61a24574
--- /dev/null
+++ b/drivers/nvmem/max77759-nvmem.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright 2020 Google Inc
+// Copyright 2025 Linaro Ltd.
+//
+// NVMEM driver for Maxim MAX77759
+
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/device/driver.h>
+#include <linux/err.h>
+#include <linux/mfd/max77759.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+
+#define MAX77759_NVMEM_OPCODE_HEADER_LEN 3
+/*
+ * NVMEM commands have a three byte header (which becomes part of the command),
+ * so we need to subtract that.
+ */
+#define MAX77759_NVMEM_SIZE (MAX77759_MAXQ_OPCODE_MAXLENGTH \
+			     - MAX77759_NVMEM_OPCODE_HEADER_LEN)
+
+struct max77759_nvmem {
+	struct device *dev;
+	struct max77759 *max77759;
+};
+
+static bool max77759_nvmem_is_valid(unsigned int offset, size_t bytes)
+{
+	return (offset + bytes - 1 <= MAX77759_NVMEM_SIZE);
+}
+
+static int max77759_nvmem_reg_read(void *priv, unsigned int offset,
+				   void *val, size_t bytes)
+{
+	struct max77759_nvmem *nvmem = priv;
+	DEFINE_FLEX(struct max77759_maxq_command, cmd, cmd, length,
+		    MAX77759_NVMEM_OPCODE_HEADER_LEN);
+	DEFINE_FLEX(struct max77759_maxq_response, rsp, rsp, length,
+		    MAX77759_MAXQ_OPCODE_MAXLENGTH);
+	int ret;
+
+	if (!max77759_nvmem_is_valid(offset, bytes)) {
+		dev_err(nvmem->dev, "outside NVMEM area: %u / %zu\n",
+			offset, bytes);
+		return -EINVAL;
+	}
+
+	cmd->cmd[0] = MAX77759_MAXQ_OPCODE_USER_SPACE_READ;
+	cmd->cmd[1] = offset;
+	cmd->cmd[2] = bytes;
+	rsp->length = bytes + MAX77759_NVMEM_OPCODE_HEADER_LEN;
+
+	ret = max77759_maxq_command(nvmem->max77759, cmd, rsp);
+	if (ret < 0)
+		return ret;
+
+	if (memcmp(cmd->cmd, rsp->rsp, MAX77759_NVMEM_OPCODE_HEADER_LEN)) {
+		dev_warn(nvmem->dev, "protocol error (read)\n");
+		return -EIO;
+	}
+
+	memcpy(val, &rsp->rsp[MAX77759_NVMEM_OPCODE_HEADER_LEN], bytes);
+
+	return 0;
+}
+
+static int max77759_nvmem_reg_write(void *priv, unsigned int offset,
+				    void *val, size_t bytes)
+{
+	struct max77759_nvmem *nvmem = priv;
+	DEFINE_FLEX(struct max77759_maxq_command, cmd, cmd, length,
+		    MAX77759_MAXQ_OPCODE_MAXLENGTH);
+	DEFINE_FLEX(struct max77759_maxq_response, rsp, rsp, length,
+		    MAX77759_MAXQ_OPCODE_MAXLENGTH);
+	int ret;
+
+	if (!max77759_nvmem_is_valid(offset, bytes)) {
+		dev_err(nvmem->dev, "outside NVMEM area: %u / %zu\n",
+			offset, bytes);
+		return -EINVAL;
+	}
+
+	cmd->cmd[0] = MAX77759_MAXQ_OPCODE_USER_SPACE_WRITE;
+	cmd->cmd[1] = offset;
+	cmd->cmd[2] = bytes;
+	memcpy(&cmd->cmd[MAX77759_NVMEM_OPCODE_HEADER_LEN], val, bytes);
+	cmd->length = bytes + MAX77759_NVMEM_OPCODE_HEADER_LEN;
+	rsp->length = cmd->length;
+
+	ret = max77759_maxq_command(nvmem->max77759, cmd, rsp);
+	if (ret < 0)
+		return ret;
+
+	if (memcmp(cmd->cmd, rsp->rsp, cmd->length)) {
+		dev_warn(nvmem->dev, "protocol error (write)\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int max77759_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = {
+		.dev = &pdev->dev,
+		.name = dev_name(&pdev->dev),
+		.id = NVMEM_DEVID_NONE,
+		.type = NVMEM_TYPE_EEPROM,
+		.ignore_wp = true,
+		.size = MAX77759_NVMEM_SIZE,
+		.word_size = sizeof(u8),
+		.stride = sizeof(u8),
+		.reg_read = max77759_nvmem_reg_read,
+		.reg_write = max77759_nvmem_reg_write,
+	};
+	struct max77759_nvmem *nvmem;
+
+	nvmem = devm_kzalloc(&pdev->dev, sizeof(*nvmem), GFP_KERNEL);
+	if (!nvmem)
+		return -ENOMEM;
+
+	nvmem->dev = &pdev->dev;
+	nvmem->max77759 = dev_get_drvdata(pdev->dev.parent);
+
+	config.priv = nvmem;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
+}
+
+static const struct of_device_id max77759_nvmem_of_id[] = {
+	{ .compatible = "maxim,max77759-nvmem", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max77759_nvmem_of_id);
+
+static const struct platform_device_id max77759_nvmem_platform_id[] = {
+	{ "max77759-nvmem", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, max77759_nvmem_platform_id);
+
+static struct platform_driver max77759_nvmem_driver = {
+	.driver = {
+		.name = "max77759-nvmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = max77759_nvmem_of_id,
+	},
+	.probe = max77759_nvmem_probe,
+	.id_table = max77759_nvmem_platform_id,
+};
+
+module_platform_driver(max77759_nvmem_driver);
+
+MODULE_AUTHOR("André Draszik <andre.draszik@linaro.org>");
+MODULE_DESCRIPTION("NVMEM driver for Maxim MAX77759");
+MODULE_LICENSE("GPL");

-- 
2.49.0.901.g37484f566f-goog


