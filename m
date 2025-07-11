Return-Path: <linux-kernel+bounces-727858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106B7B020B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E94A60847
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3F12EE5E8;
	Fri, 11 Jul 2025 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FJikJ7mO"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DA92ED176
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248563; cv=none; b=CqqylsJAvfyPpp5zHWaDzL+RQuPKbqp1eK44oMeTzoQKTFSh8vPI1MId9OA5AbtYL3UAWDAg9+KWK0xvt5VB12Trd9uYmJTwb4ccbU/aFiWNZ6Tqcjw0XaavHV2jE0NXEMZbp34i2TgGc89Z5osb5MvS0d06/aURToSM17UodM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248563; c=relaxed/simple;
	bh=nGjnp3fjRIAwuCPe4X8xA3NuqItplQbCbsENjgZv6CA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQXDGg4OIOnX6GfbipxSdVts6r5hiVQwJmjUGd7smRhSDsoGY8cXuSavMnS1YmSGHMlExkR807i61JQQeHcUfaCiExFVnricMDDQN0S8i7RRZDMsgIejl+FB4FCeQL6gG67E3MQjl5WJnT51WX3/YBVDqEgRrQPKrMTi/1GRQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FJikJ7mO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74264d1832eso3051951b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752248561; x=1752853361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxVX0Y3q1zKn8AHlmxm4fkgMmDWH56ItPYhoC7G/EYs=;
        b=FJikJ7mO92kBoJlNLfDc5LIWYPy0BZNZiNBEsNfrxeeLdEoN0UMQz36+/jHRqd0FPE
         chNtlxmjRmCsOTHt8TYnGRqz7Ip6/hGPOqOiPQkHzu7yrFoKgoFuR4hCPFDXNF7blPPJ
         eiV+aPyJBJIU5FlC58afRO+gKwgey5xFlAL3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248561; x=1752853361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxVX0Y3q1zKn8AHlmxm4fkgMmDWH56ItPYhoC7G/EYs=;
        b=KG0D6lL6AuC5irUe3CB9wEzoyRFuZ8zPd9JpwP881t7GtovL3C/XdZ5W/jvtHBM2Vb
         l3h+AEC9oBnHrEKIUraDfCyMj++tokUKF8+sIQWeeXuO8g/3u4rRCizWUX09BXp1uLCC
         K9AQholMsP7/EjzUVZuL2EbBSKnqtYcFJ6TXreftt7E6xyVuxTHvS+lBeeay/RS7tmZi
         HN8lP5O7UAYG98TVYUQ5VCQKUFl9+QHwxNBPw8AFwUSiayMfNHlgv3etd9dtaPONNTVl
         Boujtq200HjZDbG2Y6zBZkHvST3A1ZA1xHqRmDKUJ8fLqIhBNIL48UB15rzsoxuYcZ8v
         xsgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0hfeSNwM0ciKKf44GW3OsRDsZSpQr+bPZgoYZ7iO0iFMvf0OQewpkGajxfaBsS0QiN3fwod76boWfLf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpEqUl+dRLayEsE3OiHEN43KhUUY16EpWAWqNJfUDhzOWU44hI
	F+j9SbB+rhsT1jDPo00RCqNUF6pNPbYPrTJ6hC07LVDMEDk+RR/PjylMkjapXCR5/g==
X-Gm-Gg: ASbGncuy9qNKdRSgQeOMa0lBJw/pbV+TFk64g5kU2yrWx/6pTe0LtajftIBamXnhqaU
	+q+zY0bQE3TEBQP7v8iNwlAmKiviZK93vWmnLsc7sB0u9J1C6+rd01y6EpWpdmNRn10hv7olsPR
	5r2sLTgsBY1/AO3bHggot/H7WZrarTWVaoxxGlb6v+Vgkc+yxw1CxPJ9gOZV18zoogxndqOkTpM
	sUXmgMV3VA2e2MXGzSd+erha/Prd/A/gOPomSVSREGcWTrEGnYgHEksqPWnbyTG4FTU9szNDO1e
	3n4J2Fz0YHgoyFKa16/RMQ00qU3tw8HRENk1yqaxu8HHbViyqP2ME2wiuodi6lkNPwYkzYzPdvN
	Ie/MXW4dn+/UN71G/YpLSh/wVa3w6K1Yg0uTVsVDXtv+NZUGWek4wd1CVb0wVqyuj227P
X-Google-Smtp-Source: AGHT+IHvi48zWnlChEAQBDWzefinVC/2H0fk+4SbSA/0wv9N/ywaQmI7QE1QuH03kCgKn58gcjxDIQ==
X-Received: by 2002:a05:6a00:4fc1:b0:748:f750:14c6 with SMTP id d2e1a72fcca58-74ee244a41emr4543842b3a.14.1752248561343;
        Fri, 11 Jul 2025 08:42:41 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ccesm5762420b3a.27.2025.07.11.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:42:40 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	kamal.dasu@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH 2/4] hwspinlock: brcmstb hardware semaphore support
Date: Fri, 11 Jul 2025 11:42:19 -0400
Message-Id: <20250711154221.928164-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711154221.928164-1-kamal.dasu@broadcom.com>
References: <20250711154221.928164-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kamal Dasu <kdasu@broadcom.com>

Added support for brmstb_hwspinlock driver that makes use of
the hwspinlock framework. Driver uses SUN_TOP_CTRL_SEMAPHORE_[1:15]
registers to implement the hardware semaphore. With this change
other brcmstb drivers can use hwspin_trylock() and hwspin_unlock()
apis and make use of this hwspinlock framework. Other driver dt nodes
just need to use a reference to the &hwspinlock and the lock id
they want to use.
e.g. hwlocks = <&hwspinlock0 0>;

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/hwspinlock/Kconfig              |  9 +++
 drivers/hwspinlock/Makefile             |  1 +
 drivers/hwspinlock/brcmstb_hwspinlock.c | 98 +++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 3874d15b0e9b..551afa8df2d0 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -63,4 +63,13 @@ config HSEM_U8500
 
 	  If unsure, say N.
 
+config HWSPINLOCK_BRCMSTB
+	tristate "Broadcom Setttop Hardware Semaphore functionality"
+	depends on ARCH_BRCMSTB || COMPILE_TEST
+	help
+	  Broadcom settop hwspinlock driver.
+	  Say y here to support the Broadcom Hardware Semaphore functionality, which
+	  provides a synchronisation mechanism on the SoC.
+
+	  If unsure, say N.
 endif # HWSPINLOCK
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index a0f16c9aaa82..4f5c05403209 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SUN6I)		+= sun6i_hwspinlock.o
 obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
+obj-$(CONFIG_HWSPINLOCK_BRCMSTB)	+= brcmstb_hwspinlock.o
diff --git a/drivers/hwspinlock/brcmstb_hwspinlock.c b/drivers/hwspinlock/brcmstb_hwspinlock.c
new file mode 100644
index 000000000000..c27d53e06edf
--- /dev/null
+++ b/drivers/hwspinlock/brcmstb_hwspinlock.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * brcmstb HWSEM driver
+ *
+ * Copyright (C) 2025 Broadcom
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/hwspinlock.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include "hwspinlock_internal.h"
+
+#define BRCMSTB_MAX_SEMAPHORES		16
+#define RESET_SEMAPHORE			0
+
+#define HWSPINLOCK_VAL			'L'
+
+static int brcmstb_hwspinlock_trylock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = lock->priv;
+
+	writel(HWSPINLOCK_VAL, lock_addr);
+
+	return (readl(lock_addr) == HWSPINLOCK_VAL);
+}
+
+static void brcmstb_hwspinlock_unlock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = lock->priv;
+
+	/* release the lock by writing 0 to it */
+	writel(RESET_SEMAPHORE, lock_addr);
+}
+
+static void brcmstb_hwspinlock_relax(struct hwspinlock *lock)
+{
+	ndelay(50);
+}
+
+static const struct hwspinlock_ops brcmstb_hwspinlock_ops = {
+	.trylock	= brcmstb_hwspinlock_trylock,
+	.unlock		= brcmstb_hwspinlock_unlock,
+	.relax		= brcmstb_hwspinlock_relax,
+};
+
+static int brcmstb_hwspinlock_probe(struct platform_device *pdev)
+{
+	struct hwspinlock_device *bank;
+	struct hwspinlock *hwlock;
+	void __iomem *io_base;
+	int i, num_locks = BRCMSTB_MAX_SEMAPHORES;
+
+	io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io_base)) {
+		dev_err(&pdev->dev, "semaphore iobase mapping error\n");
+		return PTR_ERR(io_base);
+	}
+
+	bank = devm_kzalloc(&pdev->dev, struct_size(bank, lock, num_locks),
+			    GFP_KERNEL);
+	if (!bank)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, bank);
+
+	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
+		hwlock->priv = io_base + sizeof(u32) * i;
+
+	return devm_hwspin_lock_register(&pdev->dev, bank,
+					 &brcmstb_hwspinlock_ops,
+					 0, num_locks);
+}
+
+static const struct of_device_id brcmstb_hwspinlock_ids[] = {
+	{ .compatible = "brcm,brcmstb-hwspinlock", },
+	{ /* end */ },
+};
+MODULE_DEVICE_TABLE(of, brcmstb_hwspinlock_ids);
+
+static struct platform_driver brcmstb_hwspinlock_driver = {
+	.probe		= brcmstb_hwspinlock_probe,
+	.driver		= {
+		.name	= "brcmstb_hwspinlock",
+		.of_match_table = brcmstb_hwspinlock_ids,
+	},
+};
+
+module_platform_driver(brcmstb_hwspinlock_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hardware Spinlock driver for brcmstb");
+MODULE_AUTHOR("Kamal Dasu <kdasu@broadcom.com>");
-- 
2.34.1


