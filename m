Return-Path: <linux-kernel+bounces-722692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B58AFDDBF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7169E585A86
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38011E47CA;
	Wed,  9 Jul 2025 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TXI10J6O"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CA61E25E3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029800; cv=none; b=aPm9WbIOgAsW43r2AwoCPFkVHdzv3fJ5Nu+eKjrPPp30Ay3wfwrVYMJj+BhxsF5LLB6OPrIUTmP7axqdXK/VyedAiiDEXJPGr9DQpPlmfAfxYOqFN5pp6XY2ZIjr17cbmKR2uO2TqtBQN7/R7bqwNX4SVsIurHuaQ6vWiOtSCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029800; c=relaxed/simple;
	bh=SHYitzceRK6LAZnlNhpoC2/XnbFor3kpZM3us1fxg68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SdXsu2gLoe12yIQ/wDw31F9QVCPrcP1wM558YCww4y239Na7xkERyByRalsyXcue8o6/kJ/bKCkGdUvAUCRVswMAT0ULf5anvF0dwCd8qsZZdqmWa7rmerIRTQEGQIuSNTH17T4AtYcBolalNP5bKT1FTMWU3wZe5T9WI2MWiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TXI10J6O; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so83856336d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1752029796; x=1752634596; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rg1PwZb/Nj9zinwW4tBBT6J6d/gy4SIm72/5Qr/32aU=;
        b=TXI10J6OacZ0rOOjve08mN8mmc6o8W8v3TRNZw61+Iu2IUgU0syZ+dDiW3cHHfPeYn
         6lsXqWTaxsopO+cJ2BQSIBbYeeprb++UIW5gJbV8tb3acKB7KownGrgpjAAsc1fNKebb
         Hw3s8Vujrj6S4dd/oMLd6m7q7IWbkThdkHnbxRHXCv4IPfTln0Gv/cGihFYG5j1uTorB
         M3KsyZGslmFILbZPgHzAg6Dhz2vjmM9LOlON2sSlFuLCoP+GuMdo3Q/Yb34yh+LfYzNU
         RX9CWwqCSY+S01T4Tbno1BufF6HrFN772QhagS/s5YMRAudRrDlO+923KtI4aOyDe5Wm
         WETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029796; x=1752634596;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rg1PwZb/Nj9zinwW4tBBT6J6d/gy4SIm72/5Qr/32aU=;
        b=j+0eLioHwBUncfrv7CbcGdvOhZavr0b6Qgd00HeZRFZb3h5UmLPd2fSgArlwxg9nv6
         U4W9h0Rtqggge9RB0q10q/0RBpNlmz0P3v9Kjq/AZYo5zjGWjzBFqQdbScaPFLW7PrZz
         SPk8HweMsiE4+z/GFzbarYfXYQ6yp+etBesxZiKFL/3T0BElbeyPW6fU3JIR3hvxNsKa
         GbNvRhnCsHLzI4nhazBtzhEzzkBX4kvKIqPdVl/dIV2NSPpnqhIwscJ1xGFE900rCsAv
         af1VLI3y2q6Y+ISDKAjOJw2j5/0MNQwPBU2UmKDvK0uEJL2JRLkYBujGLFQy25QULDzL
         6SOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwNnoeUNpW9ewTDJRLs2ULInwyb735fidTq/xEp/UthdbWys06i129yBPkEkTtrneLsq075oZQJvzHnfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqWivaT5qEWDGOyy5G2dTACtMQnSpYYb4B9qFd0EFMZNJjvd2
	R9Z90p3uuvD0y8c7IgQXYwjqTvxY4rweKD5UMSe1uKRNG5FL2124i381booLs0nckHk=
X-Gm-Gg: ASbGncsnd1TgDV40z6f7PM3HE98dh6c9BuETd9sVNTolJmFEK2JRuLwmVoZuEKSTpaW
	aTJyAA4U3HebvlW6ReKLpu4B91a1wTrnAr/57zBQAEYmy5Zh7anzhMe0fH/9CvOt4Tx1qy7XUVY
	JBWn7QJ/E7xn2w81Iuw2Zs4EJ1tDMvr9orSCnS+HGhksN0xXY4t9QNOcT+WtU5BOY2S0+7qkicV
	UVhOeSz4KVsesugr1HEFdGJ9K7qJsM1l/BKy5bR2pyrk5Vcql4vn8/B9uL+WzjGNX1/6ImaOmS5
	F2qUoEsy2RIYQd8YtWo3SGKawEnP2o4EaA8d2Qh5GxabKHdesjM5dyqdN9SoyaMaxdmym2K5sAQ
	0+PxFW+Rn
X-Google-Smtp-Source: AGHT+IE2w+6pcL8ow4gEfiQsAilesspsCHatY+WU2AnhEdGzmw3Vr+kWUWblRdjFmoueDfNIhkUnFg==
X-Received: by 2002:a05:6214:1c08:b0:702:d997:71d4 with SMTP id 6a1803df08f44-7048b94bb8cmr13576576d6.24.1752029796113;
        Tue, 08 Jul 2025 19:56:36 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb2318sm867257585a.107.2025.07.08.19.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:56:35 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 2/2] irqchip/riscv-aplic: Save and restore APLIC registers
Date: Wed,  9 Jul 2025 10:55:16 +0800
Message-Id: <20250709025516.28051-3-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250709025516.28051-1-nick.hu@sifive.com>
References: <20250709025516.28051-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The APLIC may be powered down when the CPUs enter a deep sleep state.
Therefore adding the APLIC save and restore functions to save and
restore the states of APLIC.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
---
 drivers/irqchip/irq-riscv-aplic-direct.c |  14 ++-
 drivers/irqchip/irq-riscv-aplic-main.c   | 143 +++++++++++++++++++++++
 drivers/irqchip/irq-riscv-aplic-main.h   |  12 ++
 drivers/irqchip/irq-riscv-aplic-msi.c    |   3 +-
 4 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 205ad61d15e4..df42f979d02c 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
@@ -171,6 +172,16 @@ static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
 	writel(de, idc->regs + APLIC_IDC_IDELIVERY);
 }
 
+void aplic_direct_restore(struct aplic_priv *priv)
+{
+	struct aplic_direct *direct =
+			container_of(priv, struct aplic_direct, priv);
+	int cpu;
+
+	for_each_cpu(cpu, &direct->lmask)
+		aplic_idc_set_delivery(per_cpu_ptr(&aplic_idcs, cpu), true);
+}
+
 static int aplic_direct_dying_cpu(unsigned int cpu)
 {
 	if (aplic_direct_parent_irq)
@@ -343,5 +354,6 @@ int aplic_direct_setup(struct device *dev, void __iomem *regs)
 	dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
 		 priv->nr_irqs, priv->nr_idcs);
 
-	return 0;
+	/* Add the aplic_priv to the list */
+	return aplic_add(dev, priv);
 }
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 93e7c51f944a..9054ce7a7256 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -12,10 +12,130 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
+#include <linux/syscore_ops.h>
 
 #include "irq-riscv-aplic-main.h"
 
+static LIST_HEAD(aplics);
+
+static void aplic_restore(struct aplic_priv *priv)
+{
+	int i;
+	u32 clrip;
+
+	writel(priv->saved_domaincfg, priv->regs + APLIC_DOMAINCFG);
+#ifdef CONFIG_RISCV_M_MODE
+	writel(priv->saved_msiaddr, priv->regs + APLIC_xMSICFGADDR);
+	writel(priv->saved_msiaddrh, priv->regs + APLIC_xMSICFGADDRH);
+#endif
+	for (i = 1; i <= priv->nr_irqs; i++) {
+		writel(priv->saved_sourcecfg[i - 1],
+		       priv->regs + APLIC_SOURCECFG_BASE +
+		       (i - 1) * sizeof(u32));
+		writel(priv->saved_target[i - 1],
+		       priv->regs + APLIC_TARGET_BASE +
+		       (i - 1) * sizeof(u32));
+	}
+
+	for (i = 0; i <= priv->nr_irqs; i += 32) {
+		writel(-1U, priv->regs + APLIC_CLRIE_BASE +
+			    (i / 32) * sizeof(u32));
+		writel(priv->saved_ie[i / 32],
+		       priv->regs + APLIC_SETIE_BASE +
+		       (i / 32) * sizeof(u32));
+	}
+
+	if (priv->nr_idcs) {
+		aplic_direct_restore(priv);
+	} else {
+		/* Re-trigger the interrupts */
+		for (i = 0; i <= priv->nr_irqs; i += 32) {
+			clrip = readl(priv->regs + APLIC_CLRIP_BASE +
+				      (i / 32) * sizeof(u32));
+			writel(clrip, priv->regs + APLIC_SETIP_BASE +
+				      (i / 32) * sizeof(u32));
+		}
+	}
+}
+
+static void aplic_save(struct aplic_priv *priv)
+{
+	int i;
+
+	for (i = 1; i <= priv->nr_irqs; i++) {
+		priv->saved_target[i - 1] = readl(priv->regs +
+						  APLIC_TARGET_BASE +
+						  (i - 1) * sizeof(u32));
+	}
+
+	for (i = 0; i <= priv->nr_irqs; i += 32) {
+		priv->saved_ie[i / 32] = readl(priv->regs +
+					       APLIC_SETIE_BASE +
+					       (i / 32) * sizeof(u32));
+	}
+}
+
+static int aplic_syscore_suspend(void)
+{
+	struct aplic_priv *priv;
+
+	list_for_each_entry(priv, &aplics, list) {
+		aplic_save(priv);
+	}
+
+	return 0;
+}
+
+static void aplic_syscore_resume(void)
+{
+	struct aplic_priv *priv;
+
+	list_for_each_entry(priv, &aplics, list) {
+		aplic_restore(priv);
+	}
+}
+
+static struct syscore_ops aplic_syscore_ops = {
+	.suspend = aplic_syscore_suspend,
+	.resume = aplic_syscore_resume,
+};
+
+static int aplic_notifier(struct notifier_block *nb, unsigned long action,
+			  void *data)
+{
+	struct aplic_priv *priv = container_of(nb, struct aplic_priv, genpd_nb);
+
+	switch (action) {
+	case GENPD_NOTIFY_PRE_OFF:
+		aplic_save(priv);
+		break;
+	case GENPD_NOTIFY_ON:
+		aplic_restore(priv);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int aplic_add(struct device *dev, struct aplic_priv *priv)
+{
+	int ret;
+
+	list_add(&priv->list, &aplics);
+	/* Add genpd notifier */
+	priv->genpd_nb.notifier_call = aplic_notifier;
+	ret = dev_pm_genpd_add_notifier(dev, &priv->genpd_nb);
+	if (!ret)
+		return devm_pm_runtime_enable(dev);
+
+	return ret == -ENODEV || ret == -EOPNOTSUPP ? 0 : ret;
+}
+
 void aplic_irq_unmask(struct irq_data *d)
 {
 	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
@@ -59,6 +179,7 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int type)
 	sourcecfg = priv->regs + APLIC_SOURCECFG_BASE;
 	sourcecfg += (d->hwirq - 1) * sizeof(u32);
 	writel(val, sourcecfg);
+	priv->saved_sourcecfg[d->hwirq - 1] = val;
 
 	return 0;
 }
@@ -95,6 +216,8 @@ void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
 		valh |= FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicfg.hhxs);
 		writel(val, priv->regs + APLIC_xMSICFGADDR);
 		writel(valh, priv->regs + APLIC_xMSICFGADDRH);
+		priv->saved_msiaddr = val;
+		priv->saved_msiaddrh = valH;
 	}
 #endif
 
@@ -106,6 +229,7 @@ void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
 	writel(val, priv->regs + APLIC_DOMAINCFG);
 	if (readl(priv->regs + APLIC_DOMAINCFG) != val)
 		dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n", val);
+	priv->saved_domaincfg = val;
 }
 
 static void aplic_init_hw_irqs(struct aplic_priv *priv)
@@ -176,6 +300,23 @@ int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *
 	/* Setup initial state APLIC interrupts */
 	aplic_init_hw_irqs(priv);
 
+	/* For power management */
+	priv->saved_target = devm_kzalloc(dev, priv->nr_irqs * sizeof(u32),
+					  GFP_KERNEL);
+	if (!priv->saved_target)
+		return -ENOMEM;
+
+	priv->saved_sourcecfg = devm_kzalloc(dev, priv->nr_irqs * sizeof(u32),
+					     GFP_KERNEL);
+	if (!priv->saved_sourcecfg)
+		return -ENOMEM;
+
+	priv->saved_ie = devm_kzalloc(dev,
+				      DIV_ROUND_UP(priv->nr_irqs, 32) * sizeof(u32),
+				      GFP_KERNEL);
+	if (!priv->saved_ie)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -209,6 +350,8 @@ static int aplic_probe(struct platform_device *pdev)
 	if (rc)
 		dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\n",
 			      msi_mode ? "MSI" : "direct");
+	else
+		register_syscore_ops(&aplic_syscore_ops);
 
 #ifdef CONFIG_ACPI
 	if (!acpi_disabled)
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
index b0ad8cde69b1..969319242dbc 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.h
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -31,6 +31,16 @@ struct aplic_priv {
 	u32			acpi_aplic_id;
 	void __iomem		*regs;
 	struct aplic_msicfg	msicfg;
+	struct notifier_block	genpd_nb;
+	struct list_head	list;
+	u32 *saved_target;
+	u32 *saved_sourcecfg;
+	u32 *saved_ie;
+	u32 saved_domaincfg;
+#ifdef CONFIG_RISCV_M_MODE
+	u32 saved_msiaddr;
+	u32 saved_msiaddrh;
+#endif
 };
 
 void aplic_irq_unmask(struct irq_data *d);
@@ -39,7 +49,9 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int type);
 int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
 			      unsigned long *hwirq, unsigned int *type);
 void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
+void aplic_direct_restore(struct aplic_priv *priv);
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *regs);
+int aplic_add(struct device *dev, struct aplic_priv *priv);
 int aplic_direct_setup(struct device *dev, void __iomem *regs);
 #ifdef CONFIG_RISCV_APLIC_MSI
 int aplic_msi_setup(struct device *dev, void __iomem *regs);
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index fb8d1838609f..c9b4f7d5e6ea 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -281,5 +281,6 @@ int aplic_msi_setup(struct device *dev, void __iomem *regs)
 	pa = priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
 	dev_info(dev, "%d interrupts forwarded to MSI base %pa\n", priv->nr_irqs, &pa);
 
-	return 0;
+	/* Add the aplic_priv to the list */
+	return aplic_add(dev, priv);
 }
-- 
2.17.1


