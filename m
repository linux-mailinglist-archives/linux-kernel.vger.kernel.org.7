Return-Path: <linux-kernel+bounces-836794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCB7BAA93A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094F519244D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D1825DD07;
	Mon, 29 Sep 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QA8Cu5ka"
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE025F7A4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176433; cv=none; b=glqXz0zDbdKiKqoGrALYub6Cp/LGUKcoFpdSB+nX4kp1L6vsIevVYA1MyCkFSuQxgYeAqNcQlMdfRMWcfRZrS8edu+ZeNmJQDN1L4PLvbYcwT1Vne+U08oWc7oQoFJj/VOD3ntLT6kqf/S/1t9L5Ljuom2qVgly5/zj1t+kf6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176433; c=relaxed/simple;
	bh=0JiNpHHORJSEltvIbaftdDsfMyRa/xjCyZoXBWOojB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lcf7C0jgxnDCZNaBC1ZwPOGIVrO8jimTeQmM8KfGU2TINIky35CDzGZFQlnjk7Mx5ZEpk6uel/ZVUEeVEpu5i+1DnarkcOjjvZcdu7RMmKbWOB/cwarmNGzT643SUFQ0tqyvdKGEt3dFcyzByp5ey6sUu67vcKHK6p6mfbcbR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QA8Cu5ka; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b55197907d1so3850552a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759176431; x=1759781231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wA3uOR00VQG2MYj5nJtUQY0pkQ46ZSnhVcxuOfdZq+A=;
        b=D+mZvi4mEqqY3VngOMOvEX5zxZAHVNv/pF9QywAX0wMg6/Cw4TqNkjj3dXN8RLVdhg
         hczlOMpkaozhOPrhZsrJ0iWgnTTnYZaJDOc0BJaHLJhAI5uhmvSurxxrnyrWIB/mnqcq
         l9UJEwilJN8rqpz5Sf/mElhXqj60atJ+kJjCKhLxnSPkJkoxFHQX/0k8sNGclATgvj1F
         mGjaJh5sc9rnqJWkAKBjK+5N26AAScFHHaquYb7poIwwUaSHX7qbsidplIoGpnEAHSDw
         yJmbbnALpXCAjAUAE0+/pZIL+ZTfK5DOAQOUahLJ5ENjx2tbjmJxonwsLKAYYNU9KnvI
         kX5w==
X-Forwarded-Encrypted: i=1; AJvYcCW/DKuO26Xl1hWAGtRX4NgkwuFd8xsABJxTdtutkUBcJIPdiTY6R5yWn6JxM79heGuWlyuJrvZBRtnWQQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDTiMVY/m0FWwjOSZNM44jzCS5jBt0HsXknlaV/XC+qJmYd9q
	wOHcvOdNnAcwIEqFKY3xqyO/abb9gi4oku29vRGigaNNsVRT5NW1ngJACqxdE9uVC3dr/cDIeOx
	0Qu1gmAyok54dJWrzMffuvIUaqoeU9tZMYq7dzttjmL+7oiDNA91q3C7NrBBfl5LQXmNOpJW7Bz
	31oAZrU2n4uR6w5pL7Z5q4BeGz2PwQssSpxkt84+lUe0fONyd1q7URJlt3R8pa4XmdPORUGNXJF
	fr4uOO7eXRBaFd0
X-Gm-Gg: ASbGncubo6+7xTqUcj+ItC8otJPYCqCoTSSBcE5AhEIUsuDRxI2ZnEOsHgc2xDZDrCA
	LFyQpojv9XR3SfhO/Sl0H6TKHXzYCLgRUCZ9FtyifJIm1atBnYJA41Ksc0SJDdWLz8Df+Gpddu+
	otmQ0g3W3Y9uyls6d1vWvXRkRkOiIn8NTdZe/AaPBoRIEc7J2haP02+JQ28B1euPXpAB9m9py6m
	JYOknTJLlNXq2lPFDfJo/suHgGdR7hs1bHYPueM4o+FkfaiY8QIHtkmSYctwer3kX1y2nP5giUv
	kt/CFPETbIk+DmYVc5YYZB90N81IIK/4n+BxHHcpRo/o7YVtl/VnVitkHgZvjFU17vFljcCWQ/8
	lfsUn8/vpOzSju5ljVNId
X-Google-Smtp-Source: AGHT+IE7t4YTsjVDYBmhgX3s690G81MF1RX7xIG1YTYZJEFHFs1sP9YS8Z0Cl6IQtQF+XfqHf6/wS00wzFxz
X-Received: by 2002:a17:903:13c8:b0:283:c950:a76f with SMTP id d9443c01a7336-283c96f311cmr79747085ad.43.1759176431294;
        Mon, 29 Sep 2025 13:07:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed67e6a34sm9964525ad.38.2025.09.29.13.07.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2025 13:07:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so4572426a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759176429; x=1759781229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA3uOR00VQG2MYj5nJtUQY0pkQ46ZSnhVcxuOfdZq+A=;
        b=QA8Cu5katZ4+YsdeF0z9cRRtT3nJdYwa4UZBK935GyI+j8NEAaIHz91+ipctD+qyZg
         CHwtouaLUlMobGdlOZw7icLyvPFjimfnKdIF/jsl7TrbImCBJpdjJ+nRnZ+DfNmUbnqe
         F9wuezyjOsj8ZzmaYq3QnOpwJKtIWQ1qTi8O0=
X-Forwarded-Encrypted: i=1; AJvYcCW4IoN2CrU2gw/8ejt7tPZCIHHZZDAC3WtRCWSdUZ1QC/dZ0cd9rH6Rtvt/1OrCpJJEkerdfYNEPmfg1sM=@vger.kernel.org
X-Received: by 2002:a17:90b:3143:b0:32e:1ff5:5af4 with SMTP id 98e67ed59e1d1-3342a2fe9ddmr18545837a91.35.1759176429373;
        Mon, 29 Sep 2025 13:07:09 -0700 (PDT)
X-Received: by 2002:a17:90b:3143:b0:32e:1ff5:5af4 with SMTP id 98e67ed59e1d1-3342a2fe9ddmr18545816a91.35.1759176428992;
        Mon, 29 Sep 2025 13:07:08 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33838735194sm2121479a91.22.2025.09.29.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 13:07:08 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 2/3] hwspinlock: brcmstb hardware semaphore support
Date: Mon, 29 Sep 2025 16:06:26 -0400
Message-Id: <20250929200628.3699525-4-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
References: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

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
index 000000000000..56206431a94c
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
+	void __iomem *lock_addr = (void __iomem *)lock->priv;
+
+	writel(HWSPINLOCK_VAL, lock_addr);
+
+	return (readl(lock_addr) == HWSPINLOCK_VAL);
+}
+
+static void brcmstb_hwspinlock_unlock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = (void __iomem *)lock->priv;
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
+		hwlock->priv = (void __iomem *)(io_base + sizeof(u32) * i);
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
+MODULE_AUTHOR("Kamal Dasu <kdasu.dasu@broadcom.com>");
-- 
2.34.1


