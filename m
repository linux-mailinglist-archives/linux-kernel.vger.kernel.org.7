Return-Path: <linux-kernel+bounces-847461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D745BCAE89
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D594F4E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC834283142;
	Thu,  9 Oct 2025 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d+kR+mEl"
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com [209.85.160.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B2281525
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044843; cv=none; b=grzyYlEfRZPmv/EILOjuqGbrXQqFvGTR2zFcWHeULKCABsU5zYhhX6dpH4grAkHElBLD5rtzaGMOnFoLlhbCEE+cBX2CrY4uVuUnY1kdBT3LqN1wfGGnriryrLgf2749GGfZxXGRKSVdw2+FkvsF1ypef1lrSSkT3Utl00H1xW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044843; c=relaxed/simple;
	bh=p/2EO6NY2oE1tAZMal4Oykrm1oaCq4qtKhqaA2pY51k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ehX7q1kQ6bYK5J0AL+suZtvKHTWtvveXxz4Sgu6uOhd0gbdE4Jci9gJiH1Jo8pTSxsdxm9q9tKNHkrcPhxA63UA49dOGmxbOcWrx1tbDGZaKLs/NKrbhKtqe5IbdIpSEBKeL+vr18Jp6PBgXMU+Y9ZoOXHl/oP/bvLn/x95Tc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d+kR+mEl; arc=none smtp.client-ip=209.85.160.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f100.google.com with SMTP id 586e51a60fabf-36f51ac0595so488623fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760044840; x=1760649640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNu9C7+Hl8/zwgHRFvABJRp0xk1fvGWapoEQB/t9/po=;
        b=AKi+kUhVjCR7eV8EH6WY9yhXkJbq6DdgvVVnXC8zc7XK2VG/aL9/C7bunorPXA7iIq
         ajzRAPi+gqMckumLy369rcV2emV0KZm81kVXe9NLM7U/OXrUvt+fjJbQNqqHRZ0A/iWM
         2bvHDPPKmm36j9Y2UUNLx/dGjyBFHE6ZMKpg1/9ZQndKp7mA4QJhVr+czC59yA9Ui/Qa
         +etuvqBQT9IIWTpi99IYN3cI0b/EaT0xL8KdtMY/zN0MEgicRwfULWEAZSmPhA/v9Lr7
         f95elppo79x8YNL2lkg9CZJexGqYIgzwLwZynSGJ5R5RwoSiiXkElBPM5oli82eJoLay
         zYLA==
X-Forwarded-Encrypted: i=1; AJvYcCXL3fPHoPuq+/8ZBISd6atlG3n6e/6K+l6v2d1irk/viWHxDt66Q4qMQyhiCWh9AM0zcrdE2RDSgApcJ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgu3kJFCuS+dHxa659GQuQQqzDWosG2pXIVF6dvURMsw5zPrn
	lp/Z5rd+BJXQVz7cZAzk8/epD532t4XXsAOYIHAAWmp3uNy406Rq7TBkLc459G2xin322Z2sYit
	sF/PgmfnQ3bdTAVt4A0YCLseyLfg+oj0hue6d9c04KLw/x5gzt+pJZUyYjz7uU3HRRY57ZetEED
	yn2ZEu+q4u8nf2Thz8RY4XhlX3DeKGX58ksB3JR0LYXxiqXIRKTGMUoYPbhg776QPLrjjAYllVF
	QPHEcA+i+X+2YLk
X-Gm-Gg: ASbGnctkqAXblSnlLgS7BYu6fsRHjoTZtNH96uybiiqObqLCeWF2Hpkk4wJLkUu779Q
	gMeMNfNEKdu0gLsfWhRb6enbkA8hoI4UcnDT0Qb+W4qm1NyyCAbqL0LXPom/kIegVt1HuUuPUeM
	jWrs+tOzSc2NfYgrQlzUnannq8YDhZUSOWQYRrYmYaT5zZiqS4yl9Cex0wLVmuA75q9SaVZqEnb
	UUwUUIIOSE3JqYmdxfnrc1/XXJHrBRhfqkq6vbnF9qHCG1wkyB3whVBi30/4HH9zZtVW0Inp5Fc
	mIxbLjbqNb4FUWd5U/Cmi9JHN30udf8pMPfiKTQ4DtwDquFDNGXTZsrzwEz4FDwbUiMId6pd6Jz
	pHwqop3XMst4BriSA4AG5kpuWUa6adJMNZy3+oAOnyOSPqgizO2XEAh3EG3iKf/6abiND5cAbkB
	4/6g==
X-Google-Smtp-Source: AGHT+IHSZuQojAYvbHXTfMnowFt3yagtrU0DqozYUHeyrRzcjqOD/FA1oM2V23tjKPXRFII26Zt89NLE5orG
X-Received: by 2002:a05:6870:c191:b0:322:52d5:bbf6 with SMTP id 586e51a60fabf-3c0f89cfe3fmr4249955fac.25.1760044840446;
        Thu, 09 Oct 2025 14:20:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3c8c8f0679asm54199fac.19.2025.10.09.14.20.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2025 14:20:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85a0492b5feso729320585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760044839; x=1760649639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNu9C7+Hl8/zwgHRFvABJRp0xk1fvGWapoEQB/t9/po=;
        b=d+kR+mElxGy8bGEzQ2CrkO4Bwv1h9Anq9WIYjKsOPs+LtDErI9BLTjaVDma0g0j7qz
         wa7Aufn1mfaebpWhEuK33/yvEZzjgeKg4VFpl/qQ0F29mc9ukZameBX5eBa8jJnVodk8
         HkHIOGUNCsBqc4UIrRPGDQy6nzcXi8j5y4I/w=
X-Forwarded-Encrypted: i=1; AJvYcCUjRbSPor5gpXe0xfgGqpyXlruz+5AyUrdLWVZLiy2siWt7YcDGeHDb77DD3Q0bI3yfAqwWq9pycoC206k=@vger.kernel.org
X-Received: by 2002:a05:620a:d89:b0:86a:3188:bb49 with SMTP id af79cd13be357-883525c06f8mr1579828885a.54.1760044839302;
        Thu, 09 Oct 2025 14:20:39 -0700 (PDT)
X-Received: by 2002:a05:620a:d89:b0:86a:3188:bb49 with SMTP id af79cd13be357-883525c06f8mr1579823385a.54.1760044838777;
        Thu, 09 Oct 2025 14:20:38 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ae428sm274832685a.16.2025.10.09.14.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:20:38 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: peng.fan@oss.nxp.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v3 2/3] hwspinlock: brcmstb hardware semaphore support
Date: Thu,  9 Oct 2025 17:20:02 -0400
Message-Id: <20251009212003.2714447-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009212003.2714447-1-kamal.dasu@broadcom.com>
References: <20251009212003.2714447-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Broadcom settop SoCs have common 16 hardware semaphore registers that
can be used as part of the kernel hardware spinlock framework. The
hardware semaphores are part of the 'sundry' ip block that also has
controls like pin/mux controls, SoC identification, drive strength,
reset controls, and other misc bits.

Adding support for brmstb_hwspinlock that only maps sundry block
registers SUN_TOP_CTRL_SEMAPHORE_[0:15] to implement the hardware
spinlock operations. Change allows other Broadcom settop drivers to
call hwspin_trylock() and hwspin_unlock() interfaces to make use of
hwspinlock framework. Other driver dt nodes just need to provide a
reference to the &hwspinlock and lock id to make use of a particular
hardware lock.
e.g. hwlocks = <&hwspinlock0 0>;

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/hwspinlock/Kconfig              | 11 ++-
 drivers/hwspinlock/Makefile             |  1 +
 drivers/hwspinlock/brcmstb_hwspinlock.c | 96 +++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwspinlock/brcmstb_hwspinlock.c

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 3874d15b0e9b..39797cadfd0b 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -8,6 +8,16 @@ menuconfig HWSPINLOCK
 
 if HWSPINLOCK
 
+config HWSPINLOCK_BRCMSTB
+	tristate "Broadcom Setttop Hardware Semaphore functionality"
+	depends on ARCH_BRCMSTB || COMPILE_TEST
+	help
+	  Broadcom settop hwspinlock driver.
+	  Say y here to support the Broadcom Hardware Semaphore functionality, which
+	  provides a synchronisation mechanism on the SoC.
+
+	  If unsure, say N.
+
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
 	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3 || COMPILE_TEST
@@ -62,5 +72,4 @@ config HSEM_U8500
 	  SoC.
 
 	  If unsure, say N.
-
 endif # HWSPINLOCK
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index a0f16c9aaa82..35f2d94d8ba2 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_HWSPINLOCK)		+= hwspinlock_core.o
+obj-$(CONFIG_HWSPINLOCK_BRCMSTB)	+= brcmstb_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_OMAP)		+= omap_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
diff --git a/drivers/hwspinlock/brcmstb_hwspinlock.c b/drivers/hwspinlock/brcmstb_hwspinlock.c
new file mode 100644
index 000000000000..0b164c57192e
--- /dev/null
+++ b/drivers/hwspinlock/brcmstb_hwspinlock.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * brcmstb HWSEM driver
+ *
+ * Copyright (C) 2025 Broadcom
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/hwspinlock.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include "hwspinlock_internal.h"
+
+#define BRCMSTB_NUM_SEMAPHORES		16
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
+	int i, num_locks = BRCMSTB_NUM_SEMAPHORES;
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


