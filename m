Return-Path: <linux-kernel+bounces-757440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B701B1C228
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AB6625B44
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BB17597;
	Wed,  6 Aug 2025 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gygUv4oH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0685224B12
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468867; cv=none; b=qSlr0rLG9j8aNSQjZUve4oBqbQf5El0rmyjVTXf6b0bUnIZOZTyuw6A5JZ6x0/WUVTHViTTBMBJpujzvsNwIJgIKKrEces8VnGbe5ozGV20BKDAPdxE18yuyYMPvYjWct9uyI3bExLb/UzTXVlGC+sP6De6wU29lxxqCxunw7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468867; c=relaxed/simple;
	bh=SXTfHD+dyGFqjiMQw7bsqgtVT6hyjNnRI+wIEFQMo8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ChMMC0JzEnZrtCES02NCH6m12cAe7e+gjSLIf2OA7PO7blX22Tuo/R5d8BReJOTeyG+Na02yk4zLmjmdId7QDf24LHch1E/E13KvJFFXa8bh9nK0M6Y3OzgbWlyz3kzV9pqRRpv0VEZJjTbLZ0UxU+jNMYK+5goQexFXzZOGBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gygUv4oH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2402b5396cdso41948115ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1754468865; x=1755073665; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K3CEcIdPrfApIq6dhGmfZt+45Bs79xC7g2ZEuPue/6M=;
        b=gygUv4oHWA6M6ImNe9jk6TPtUN+2t132FasNBk7z8rc52S2IZZaW0wP+JtaTBUJJrN
         HpoivFHOt9tzJQUP/71OG5LQvavD/YEgzqQ0QL5OzEWqoduULPNLgeACp7BnraCICJE4
         0F58KwOc4OfX1psVUUrulLlZahI8eM1s3VGpb6p4W8vzWE0WQ7XeHlhFvl/X/JoyqQ93
         yFOwjsZv6Q1xVEkThhkKOtNky3a6gaZij0liNP+sE1Xi/nLhXLn5Ex/DoLnE+d/85+2R
         4vnjUYvWJDlznrdm4QyN/cmRxSFxvNr5rIHOevjQvNHw0URhZONjjcq0lSZdYCL0u/AY
         fWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754468865; x=1755073665;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3CEcIdPrfApIq6dhGmfZt+45Bs79xC7g2ZEuPue/6M=;
        b=v0b9ArclpaAPGNZIKDQtbqggbBojr6Ct2uCiHOi1XgNb8VXzvVchGp6SJkjnY1qgzO
         F2UjcuIvfJdhuijh2t/lGnn9gR7HhhV2FX9LKxSEy9ucMJcSAssCQo3V6KGU4SgnCgjh
         WkT5TVydiWQGlCkJU2r/lMr7wTPzS4Ay+SotDJz+pPCFUuxoSzRDhk+tnuoWeoVxgODn
         r0X2MsDGu+XRQpY2rn1RTYMlH2pcv/jdTX3+aE17v0UQyX4piAuSd8mr6OjmMOw6PsO/
         RDKlfusifVl9qdwaOp8mMewF/3iud7feRAnss94BJQWKNpEaGFV7IHuuk0iGdVT3An99
         8uwA==
X-Forwarded-Encrypted: i=1; AJvYcCUnCjbEkVgWc2s5YAEQLvjS1GsrKYW+xYmdl7V7H5yJ8rRO7cp6gYSdg9CZc4GvN/xR5JU/+DTaJdAVpos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjOJr+fIPmq3cODmBHksS7l85DnlZ+5aZ86ZLbFumfgPo3vKn
	JyFW3HaYmIKtkPmX0sKLyNUtxh5GLml3IxINN8Vj79+mVfjyvru8nKVzIH6h/YRiSm4=
X-Gm-Gg: ASbGncuCuikRea2scLy4XBbIr+J1tm7uFEmhQasthYEF70dXt7d+7N4YVnzfbVTQvlN
	6fIRYT+WUE9I9WMI3v+MOoiegvT9s6xRpeY+6c8rQ3ZDRWODwAVC+Y5ifawbYH44gzv/ddPb7Sc
	WYPIoB7Lz0r9qu65M59+Ty8cn+UwKN/EbrgBOqxRe6Gx1tkEMUUMV+wbzwkNEFExvpNmxMjjcry
	iHNAL3r5tCHguOGDAw2J0Woy22QWjCzRnuTHHKeCFYHqFSsaI4bFlKszLyahRzAk7XWzwSt6M+J
	6bT99c181FNp5F1NUPL8qcmRF3sYCKFaCxLTK0TMOpu5SWdUK13FHLalmHuEIUmgcu8K0MehX+/
	iVqo9zG39H26wL0N0fmqCd+NCouve6c1DoVB2SXDbR/d5
X-Google-Smtp-Source: AGHT+IEMfOC8kcOgoOR6YkCT1wJ8ue+iA2kItdoT5VcS68K8udNWTH2Hm081Da8hQRywsIPvk/8qUA==
X-Received: by 2002:a17:903:3c6d:b0:237:e696:3d56 with SMTP id d9443c01a7336-2429f42a761mr43251695ad.32.1754468864911;
        Wed, 06 Aug 2025 01:27:44 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897690csm151958645ad.99.2025.08.06.01.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 01:27:44 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: anup@brainfault.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v2 2/2] irqchip/riscv-aplic: Save and restore APLIC registers
Date: Wed,  6 Aug 2025 16:27:26 +0800
Message-Id: <20250806082726.8835-3-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806082726.8835-1-nick.hu@sifive.com>
References: <20250806082726.8835-1-nick.hu@sifive.com>
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
 drivers/irqchip/irq-riscv-aplic-direct.c |  11 ++
 drivers/irqchip/irq-riscv-aplic-main.c   | 158 ++++++++++++++++++++++-
 drivers/irqchip/irq-riscv-aplic-main.h   |  11 ++
 3 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 205ad61d15e4..61b9ac2e1b7b 100644
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
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 93e7c51f944a..91fe3305934d 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -12,10 +12,143 @@
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
+	list_for_each_entry(priv, &aplics, head) {
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
+	list_for_each_entry(priv, &aplics, head) {
+		aplic_restore(priv);
+	}
+}
+
+static struct syscore_ops aplic_syscore_ops = {
+	.suspend = aplic_syscore_suspend,
+	.resume = aplic_syscore_resume,
+};
+
+static int aplic_pm_notifier(struct notifier_block *nb, unsigned long action, void *data)
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
+static void aplic_remove(void *data)
+{
+	struct aplic_priv *priv = data;
+
+	list_del(&priv->head);
+	dev_pm_genpd_remove_notifier(priv->dev);
+}
+
+static int aplic_add(struct device *dev, struct aplic_priv *priv)
+{
+	int ret;
+
+	list_add(&priv->head, &aplics);
+	/* Add genpd notifier */
+	priv->genpd_nb.notifier_call = aplic_pm_notifier;
+	ret = dev_pm_genpd_add_notifier(dev, &priv->genpd_nb);
+	if (ret && ret != -ENODEV && ret != -EOPNOTSUPP) {
+		list_del(&priv->head);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, aplic_remove, priv);
+	if (ret)
+		return ret;
+
+	return devm_pm_runtime_enable(dev);
+}
+
 void aplic_irq_unmask(struct irq_data *d)
 {
 	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
@@ -59,6 +192,7 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int type)
 	sourcecfg = priv->regs + APLIC_SOURCECFG_BASE;
 	sourcecfg += (d->hwirq - 1) * sizeof(u32);
 	writel(val, sourcecfg);
+	priv->saved_sourcecfg[d->hwirq - 1] = val;
 
 	return 0;
 }
@@ -95,6 +229,8 @@ void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
 		valh |= FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicfg.hhxs);
 		writel(val, priv->regs + APLIC_xMSICFGADDR);
 		writel(valh, priv->regs + APLIC_xMSICFGADDRH);
+		priv->saved_msiaddr = val;
+		priv->saved_msiaddrh = valh;
 	}
 #endif
 
@@ -106,6 +242,7 @@ void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
 	writel(val, priv->regs + APLIC_DOMAINCFG);
 	if (readl(priv->regs + APLIC_DOMAINCFG) != val)
 		dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n", val);
+	priv->saved_domaincfg = val;
 }
 
 static void aplic_init_hw_irqs(struct aplic_priv *priv)
@@ -176,7 +313,24 @@ int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *
 	/* Setup initial state APLIC interrupts */
 	aplic_init_hw_irqs(priv);
 
-	return 0;
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
+	return aplic_add(dev, priv);
 }
 
 static int aplic_probe(struct platform_device *pdev)
@@ -209,6 +363,8 @@ static int aplic_probe(struct platform_device *pdev)
 	if (rc)
 		dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\n",
 			      msi_mode ? "MSI" : "direct");
+	else
+		register_syscore_ops(&aplic_syscore_ops);
 
 #ifdef CONFIG_ACPI
 	if (!acpi_disabled)
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
index b0ad8cde69b1..f27d5ff1c741 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.h
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -24,6 +24,7 @@ struct aplic_msicfg {
 };
 
 struct aplic_priv {
+	struct list_head	head;
 	struct device		*dev;
 	u32			gsi_base;
 	u32			nr_irqs;
@@ -31,6 +32,15 @@ struct aplic_priv {
 	u32			acpi_aplic_id;
 	void __iomem		*regs;
 	struct aplic_msicfg	msicfg;
+	struct notifier_block	genpd_nb;
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
@@ -39,6 +49,7 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int type);
 int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
 			      unsigned long *hwirq, unsigned int *type);
 void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
+void aplic_direct_restore(struct aplic_priv *priv);
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *regs);
 int aplic_direct_setup(struct device *dev, void __iomem *regs);
 #ifdef CONFIG_RISCV_APLIC_MSI
-- 
2.17.1


