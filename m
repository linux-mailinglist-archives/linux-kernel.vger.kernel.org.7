Return-Path: <linux-kernel+bounces-897079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C7C52075
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 144114FFA59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A4530BB83;
	Wed, 12 Nov 2025 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt9wg/C1"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C013064AB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946280; cv=none; b=S9D+808bSWPPQAORe7wn2KvooZjkJ6sovVDLNCRehU+CORsNIjGdG6I/YFOFHbtwIWGD9W21fR0d/9CBThrH9Ie26tFVTC3cNRZrAMAxxTmaL2a+OzNKN8f+d+iYx62vacU1i1A5WX0LDMEqaqIEYE9fuR6FZ6vxiPH7EUYzu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946280; c=relaxed/simple;
	bh=sYEWBWdnlvpiIQxKF1/00/Hh5yUTD1kxVuE5ma/88Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOM8OB/wSVu5yadh0VfZvPfwd9Td3wcgeaSrJsPJ4aqRwiTtW3SOw40r6W+uAYs5e2ujUfJgeyqAoDyOhN+Gg6rKk0lV+HiAhR32yLhIVvTRRtpLrEIh4dmyOFRz5Vw9b1PFN4AXWNPc+nVnxpboFw9cuOm+5RWrw9Zjz4mITrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt9wg/C1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297d4ac44fbso4655255ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946277; x=1763551077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3U72yXoy8URZJehSyBgGHubHpkITsAXeWW6E7/w/5P4=;
        b=Pt9wg/C1AjXTopPwczff6S7ETOrX5qqOto7OuuXWgJIOa0naz+08J9/adx35EQ74jN
         AhnyG/OD5e3abU/slZANz6G7M1qSMw16YrhTuIvcm4VwXLJJfDWT6uMgqAGK8NQHXOkq
         /gx3iU7k9MfqJL+j50Tgzbq+mPjwRIoEYXOrdQg2p5zV4ZChrjjGi2NSqocaXBm+Ncqk
         iS7YTthBFcSlkmnL1nQIEI0hZwGttFfDkHTMHj3Oik0s9WKJzuGe97X5/tD90lXV0TGG
         JYLpmaI062uXYtjaxht7Ra2M8djMgxFH0f/8/F8dRgN1m4FwgUL6z4lE/e0O5wg/1xsa
         wWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946277; x=1763551077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3U72yXoy8URZJehSyBgGHubHpkITsAXeWW6E7/w/5P4=;
        b=t0/gVudlxiQRGOfi75e7DkqSUAzZtWwJefuyP1dwK41hKlQL6T2Cqm5QzAwKB3QRLa
         jJZLVa7VRwJ9siIjyEB1CSDx6AoL/dOrHbynh24qT2zhqBELXEKLbnQjY/tSEcqHHZEi
         TxHXnvM0W1Qzw3J9yz+0rK922aYRXUjAC3Kru6rDA1kT19AVj72jvXldkTn1uFdBx+GF
         dkKHPUsat6TfeXCTopJcNMJN0MCq4AJA1rrMbmDUWpwSHzm9UiknetlZZWRz3uyyVKML
         XlbT0fazwMLkeemsfE8pKqZtQesqQqQXdq5a3MQFw1R5z+wcGLLPhQyB5nPFXSxR9q4w
         BsJA==
X-Forwarded-Encrypted: i=1; AJvYcCUH92CtQE49We8jxzzDhYadpHhCwm235gOuywe5KoHl/YyRXhT+KM2rcTVbcMRP8MvlYlh+8TcxIHbqmaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBujsxMpzN0P6wQrJOrQOIXal9OyZfRnfrPuMjLAHGbJ7OzozK
	fFTOICroY5+U3f9Qbimd4lfU3USaMYIhNkrYh4D+26OXbNoE9DZb0cdq
X-Gm-Gg: ASbGnct5RxzaGyKby8T27OgJayIbMVIfF/02Y9bgZf1/XMXC4r2QoFFqMcBMav7yAZs
	uTzwsU++8caB5zjqxCktYg3zJHXB1MtfT/mCn9VBaf0LpIjeNnI/NQxaf5WiEJVeM+bnhLVy6bl
	/GhunJ7ccPD+hm+gIpyAHK5yW9YGJn0bG2XwUxZWq3NNhZZGwPfKQgdbM4MhVVzykIO8bf42IVX
	lQj1u0xBKPKnpJgwy2iWqrFwyvteNj8BH/DWLlLVmc5VsHmSrIlNyVOxq8gQQuMS8xiHYnyh7PY
	/NCEGlxrmy8AyKtRC+PRMd8uiq6+N9T43Um7tiyVy01vQ6CP8W5bSEEEeLifvcSW/sZSRQ6BTmM
	k8yS9s+5BbLGwESHN5k4Yy4VH53+bHKj5y7+9hMA7M8Oy9/rEKC0n7MonCQzxIhtKKjeeYZF2JR
	km3m7Rzl2VUk2t9n01+jBhdS2JLWHFEhG8DIOzpIAP7UDAaDS8J9t1kfwbm82ZwC1OOtEMWNE4C
	uUWj++nmzJJAV1c2sgaSwgII86QxSgdL0K7KpC55dxOrfzj200MCWH4ReZDC4wi7A==
X-Google-Smtp-Source: AGHT+IFuHm/8uBRLakD4dqGqWgYIv8jGlgnxHYKXY5Xa9zy45I0fwjvsmUDrL+MrrEoBjOhkIEbSVA==
X-Received: by 2002:a17:902:fc4c:b0:297:f39d:90c5 with SMTP id d9443c01a7336-2984094a5c7mr75156335ad.24.1762946277403;
        Wed, 12 Nov 2025 03:17:57 -0800 (PST)
Received: from [192.168.2.3] (2403-580a-80ed-0-4835-5a07-49e7-f115.ip6.aussiebb.net. [2403:580a:80ed:0:4835:5a07:49e7:f115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca0f28sm27386695ad.60.2025.11.12.03.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:17:57 -0800 (PST)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Wed, 12 Nov 2025 21:16:49 +1000
Subject: [PATCH v5 03/11] rtc: Add new rtc-macsmc driver for Apple Silicon
 Macs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-macsmc-subdevs-v5-3-728e4b91fe81@gmail.com>
References: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
In-Reply-To: <20251112-macsmc-subdevs-v5-0-728e4b91fe81@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 James Calligeros <jcalligeros99@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6867;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=JF8fPy7WCsEZI5w3lDmHu7AY077U0hzX/PAUVsnziAI=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDJkiOUf6qjfx3bX13OPaHsl+9DJf7Lzzk/oXr7fZLMzOb
 NYwUc29YyILgxgXg6WYIsuGJiGP2UZsN/tFKvfCzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 hjrGOkYMXJwCMNVdWowMj+7kn+laYi7w7Os5xW+iLOfM5H6bTDkfdWOC0Jaqr1lWKgz/nXuEVoS
 61E0rScoO/8J7/9gH21UH7qmf1FLL5jU/M6uJHwA=
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

From: Hector Martin <marcan@marcan.st>

Apple Silicon Macs (M1, etc.) have an RTC that is part of the PMU IC,
but most of the PMU functionality is abstracted out by the SMC.
On T600x machines, the RTC counter must be accessed via the SMC to
get full functionality, and it seems likely that future machines
will move towards making SMC handle all RTC functionality.

The SMC RTC counter access is implemented on all current machines
as of the time of this writing, on firmware 12.x. However, the RTC
offset (needed to set the time) is still only accessible via direct
PMU access. To handle this, we expose the RTC offset as an NVMEM
cell from the SPMI PMU device node, and this driver consumes that
cell and uses it to compute/set the current time.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@kernel.org>
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
 MAINTAINERS              |   1 +
 drivers/rtc/Kconfig      |  11 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-macsmc.c | 140 +++++++++++++++++++++++++
 4 files changed, 153 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e5e219c5fe6..5cf253a25831 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2464,6 +2464,7 @@ F:	drivers/nvmem/apple-spmi-nvmem.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/power/reset/macsmc-reboot.c
 F:	drivers/pwm/pwm-apple.c
+F:	drivers/rtc/rtc-macsmc.c
 F:	drivers/soc/apple/*
 F:	drivers/spi/spi-apple.c
 F:	drivers/spmi/spmi-apple-controller.c
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 2933c41c77c8..cf3fa1475ffd 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -2074,6 +2074,17 @@ config RTC_DRV_WILCO_EC
 	  This can also be built as a module. If so, the module will
 	  be named "rtc_wilco_ec".
 
+config RTC_DRV_MACSMC
+	tristate "Apple Mac System Management Controller RTC"
+	depends on MFD_MACSMC
+	help
+	  If you say yes here you get support for RTC functions
+	  inside Apple SPMI PMUs accessed through the SoC's
+	  System Management Controller
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rtc-macsmc.
+
 config RTC_DRV_MSC313
 	tristate "MStar MSC313 RTC"
         depends on ARCH_MSTARV7 || COMPILE_TEST
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 8221bda6e6dc..0485b09caceb 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_RTC_DRV_M48T35)	+= rtc-m48t35.o
 obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_MA35D1)	+= rtc-ma35d1.o
+obj-$(CONFIG_RTC_DRV_MACSMC)	+= rtc-macsmc.o
 obj-$(CONFIG_RTC_DRV_MAX31335)	+= rtc-max31335.o
 obj-$(CONFIG_RTC_DRV_MAX6900)	+= rtc-max6900.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
diff --git a/drivers/rtc/rtc-macsmc.c b/drivers/rtc/rtc-macsmc.c
new file mode 100644
index 000000000000..8fe883066956
--- /dev/null
+++ b/drivers/rtc/rtc-macsmc.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Apple SMC RTC driver
+ * Copyright The Asahi Linux Contributors
+ */
+
+#include <linux/bitops.h>
+#include <linux/mfd/macsmc.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+
+/* 48-bit RTC */
+#define RTC_BYTES 6
+#define RTC_BITS (8 * RTC_BYTES)
+
+/* 32768 Hz clock */
+#define RTC_SEC_SHIFT 15
+
+struct macsmc_rtc {
+	struct device *dev;
+	struct apple_smc *smc;
+	struct rtc_device *rtc_dev;
+	struct nvmem_cell *rtc_offset;
+};
+
+static int macsmc_rtc_get_time(struct device *dev, struct rtc_time *tm)
+{
+	struct macsmc_rtc *rtc = dev_get_drvdata(dev);
+	u64 ctr = 0, off = 0;
+	time64_t now;
+	void *p_off;
+	size_t len;
+	int ret;
+
+	ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
+	if (ret < 0)
+		return ret;
+	if (ret != RTC_BYTES)
+		return -EIO;
+
+	p_off = nvmem_cell_read(rtc->rtc_offset, &len);
+	if (IS_ERR(p_off))
+		return PTR_ERR(p_off);
+	if (len < RTC_BYTES) {
+		kfree(p_off);
+		return -EIO;
+	}
+
+	memcpy(&off, p_off, RTC_BYTES);
+	kfree(p_off);
+
+	/* Sign extend from 48 to 64 bits, then arithmetic shift right 15 bits to get seconds */
+	now = sign_extend64(ctr + off, RTC_BITS - 1) >> RTC_SEC_SHIFT;
+	rtc_time64_to_tm(now, tm);
+
+	return ret;
+}
+
+static int macsmc_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct macsmc_rtc *rtc = dev_get_drvdata(dev);
+	u64 ctr = 0, off = 0;
+	int ret;
+
+	ret = apple_smc_read(rtc->smc, SMC_KEY(CLKM), &ctr, RTC_BYTES);
+	if (ret < 0)
+		return ret;
+	if (ret != RTC_BYTES)
+		return -EIO;
+
+	/* This sets the offset such that the set second begins now */
+	off = (rtc_tm_to_time64(tm) << RTC_SEC_SHIFT) - ctr;
+	return nvmem_cell_write(rtc->rtc_offset, &off, RTC_BYTES);
+}
+
+static const struct rtc_class_ops macsmc_rtc_ops = {
+	.read_time = macsmc_rtc_get_time,
+	.set_time = macsmc_rtc_set_time,
+};
+
+static int macsmc_rtc_probe(struct platform_device *pdev)
+{
+	struct apple_smc *smc = dev_get_drvdata(pdev->dev.parent);
+	struct macsmc_rtc *rtc;
+
+	/*
+	 * MFD will probe this device even without a node in the device tree,
+	 * thus bail out early if the SMC on the current machines does not
+	 * support RTC and has no node in the device tree.
+	 */
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	rtc->dev = &pdev->dev;
+	rtc->smc = smc;
+
+	rtc->rtc_offset = devm_nvmem_cell_get(&pdev->dev, "rtc_offset");
+	if (IS_ERR(rtc->rtc_offset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_offset),
+				     "Failed to get rtc_offset NVMEM cell\n");
+
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	rtc->rtc_dev->ops = &macsmc_rtc_ops;
+	rtc->rtc_dev->range_min = S64_MIN >> (RTC_SEC_SHIFT + (64 - RTC_BITS));
+	rtc->rtc_dev->range_max = S64_MAX >> (RTC_SEC_SHIFT + (64 - RTC_BITS));
+
+	platform_set_drvdata(pdev, rtc);
+
+	return devm_rtc_register_device(rtc->rtc_dev);
+}
+
+static const struct of_device_id macsmc_rtc_of_table[] = {
+	{ .compatible = "apple,smc-rtc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, macsmc_rtc_of_table);
+
+static struct platform_driver macsmc_rtc_driver = {
+	.driver = {
+		.name = "macsmc-rtc",
+		.of_match_table = macsmc_rtc_of_table,
+	},
+	.probe = macsmc_rtc_probe,
+};
+module_platform_driver(macsmc_rtc_driver);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("Apple SMC RTC driver");
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");

-- 
2.51.2


