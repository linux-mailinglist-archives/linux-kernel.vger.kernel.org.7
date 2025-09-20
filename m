Return-Path: <linux-kernel+bounces-825896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3133BB8D101
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4ABC3A56A6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973F2DE707;
	Sat, 20 Sep 2025 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N//ME1TM"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E272DC79F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400746; cv=none; b=VzrBiFSZ06pR3w0mLdsvKNMu6cckuQVkqRiYprjx8wSGYf/WCgkKFGu5TDRAKph+MnT/btWRyds+Pibu3pq6WIl20Th/ZKEdLDcgKf97cX7ggLL5eEMUbhwgBaRBJw9PsZe6xEEwNxUBArwNJH78m+VaKRyptzZoTWcrdrZxDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400746; c=relaxed/simple;
	bh=Nrp9X20J93M2Z0cPHiM1SPqHoYdgjYD1Evoh9zUJUxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1oF6XNLcioKsINnZmSaVZywriUYJ4tVHjOi3DMZ4I2witcqiUzT7kv6KlNGe6l36GP9LnoXQUOwg/vHWL2WyBFI7x88i4f6i8RmPRU0T86LwdcxZMQES/ngFI6PKjgF1s50WyMjxEbfZlDbVmPpHfN5MvWu/tjyodjVkDeMAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N//ME1TM; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42403719c73so34187105ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400743; x=1759005543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wzj9QqNO4qwvIxbUOIweVBf21UVEh3k0y3f5MBDvAI0=;
        b=N//ME1TM6IIhya9ry8l/rxTthli5ctAv6Oxigp3M1Gx6UnKppTa665N6x45I+c16gc
         nK+3dxYk/C5zoIYQ0ggqedbK+itAuyXik4tmG0q/2MnTMj4QSNjDXqeU84wUA3AMSI+m
         Sq9w8sOK+3jOyWuwkzcjrn1LRidAG16CScNTK3EfAhDZvfSEhg8rtgGc1Rp1yQLTTamc
         AOCR2d4DgOFke8G9aF9meT7Siu6FyetvJTcE1EkvCyzapgWNrGvrETqDJlsKpJLSMboa
         aRc3v4wJW+CrMKvsLwsXR0pg06DpNJyR1cH/Xo//qUvElUIyr5Sq1l2j7Gvg4z6htZ/g
         lC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400743; x=1759005543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wzj9QqNO4qwvIxbUOIweVBf21UVEh3k0y3f5MBDvAI0=;
        b=PMfb6Ctj7NF7tH8fG3AHhTbXoiYGHnPeetu968kqVWy86C5yVPfBjDlnbra5eQnIM6
         LZnTtpIez/9qHwLK6d5dWPPyZFXmXdY4XbgBcAZuHARCzL+fJHbrzbLec7Zg/fOY3NuV
         w60S5gXMM6gW++2IYUru/9ZfHZ2QipKFPrk6mojoTx7dAtlNaViolHpxG+f+p50AXnSO
         mtbbpezHI0Aa8L8DMhSesW2rwNiiIqA2qF3p5pYD+dOV+LN9rDI6cn/9zGOch+uO1OOv
         yPf0TG5Jnna7SllwhbugWTdYyIyTM2zygvV7uw5jEFDi8WKrci0uLScT6wJCXB58D8P7
         XisQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvQifIotYsH+hZGik07FOmhpog2mrd9gjpuOBInciRRNv+EXlpoo//gPCgmxEsxATnwxRd3SRO9FNcSvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxli/jHdR9Iv5EcuhNby2q4V2n5Pr4Buqi0M1BmwELzHnZPOMad
	2JtOnsh8LWp3R2YqPuB/fn2dZlCKJ2kWcMJFFoCORp/fe7thv2FaEVBxoZaT56VwYcE=
X-Gm-Gg: ASbGncsq5HUfg2d+ItvMcwVN0x3AMnXfEpGlYfBdmJtGAqm8rqAt1/PYZYnrPE2GNki
	0+I+uUUeqTw4i5jhfIlWoC4mZweDP93prmBpyU8bwB4EFaOUsaf39c8iE7tajDGiXBzq1UnL1r+
	IRnc2eT6D3HPYG2Y/5FPcmSUlZ8b0M99mWmm2BBpNddCJB1dBoKyMkXcLfdzsSF78il/9eM+F1w
	tqvfCAQMD70TnRI6tmvjAumVKuyGaP1gT2gIB5k5EPkn5hs4mKNWCVOoOLeFUq5whCzHKvGSHVj
	UpG7j8ERpbcHhASroc1IMIk46oO9e++3VYaDBSztmK07zilehh6EfqM5l3C+C7nXHAO3nveux3q
	bzHfMVI7joVtGfBDhbBZy7LVx
X-Google-Smtp-Source: AGHT+IHNDhx657BdKsPq6ruqzboJV0R9VJJRl/BNcMcjsa3ZcQbg8UGXD6JPOkCAu++d/zncMTKjvw==
X-Received: by 2002:a05:6e02:1947:b0:424:80f2:299 with SMTP id e9e14a558f8ab-424819955bbmr133413695ab.27.1758400743103;
        Sat, 20 Sep 2025 13:39:03 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5586a4393c5sm229258173.10.2025.09.20.13.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:02 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jgg@nvidia.com,
	zong.li@sifive.com,
	tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	alex@ghiti.fr
Subject: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC access
Date: Sat, 20 Sep 2025 15:38:58 -0500
Message-ID: <20250920203851.2205115-28-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When setting irq affinity extract the IMSIC address the device
needs to access and add it to the MSI table. If the device no
longer needs access to an IMSIC then remove it from the table
to prohibit access. This allows isolating device MSIs to a set
of harts so we can now add the IRQ_DOMAIN_FLAG_ISOLATED_MSI IRQ
domain flag.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-ir.c | 143 ++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h    |   2 +
 2 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index 290d91a6c6cd..b97768cac4be 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -4,6 +4,7 @@
  *
  * Copyright © 2025 Ventana Micro Systems Inc.
  */
+#include <linux/cleanup.h>
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
@@ -106,6 +107,20 @@ static size_t riscv_iommu_ir_nr_msiptes(struct riscv_iommu_domain *domain)
 	return max_idx + 1;
 }
 
+static void riscv_iommu_ir_set_pte(struct riscv_iommu_msipte *pte, u64 addr)
+{
+	pte->pte = FIELD_PREP(RISCV_IOMMU_MSIPTE_M, 3) |
+		   riscv_iommu_phys_to_ppn(addr) |
+		   FIELD_PREP(RISCV_IOMMU_MSIPTE_V, 1);
+	pte->mrif_info = 0;
+}
+
+static void riscv_iommu_ir_clear_pte(struct riscv_iommu_msipte *pte)
+{
+	pte->pte = 0;
+	pte->mrif_info = 0;
+}
+
 static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain,
 					struct riscv_iommu_msipte *pte)
 {
@@ -149,19 +164,99 @@ static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain,
 	rcu_read_unlock();
 }
 
+static void riscv_iommu_ir_msitbl_map(struct riscv_iommu_domain *domain, size_t idx,
+				      phys_addr_t addr)
+{
+	struct riscv_iommu_msipte *pte;
+
+	if (!domain->msi_root)
+		return;
+
+	if (!refcount_inc_not_zero(&domain->msi_pte_counts[idx])) {
+		scoped_guard(raw_spinlock_irqsave, &domain->msi_lock) {
+			if (refcount_read(&domain->msi_pte_counts[idx]) == 0) {
+				pte = &domain->msi_root[idx];
+				riscv_iommu_ir_set_pte(pte, addr);
+				riscv_iommu_ir_msitbl_inval(domain, pte);
+				refcount_set(&domain->msi_pte_counts[idx], 1);
+			} else {
+				refcount_inc(&domain->msi_pte_counts[idx]);
+			}
+		}
+	}
+}
+
+static void riscv_iommu_ir_msitbl_unmap(struct riscv_iommu_domain *domain, size_t idx)
+{
+	struct riscv_iommu_msipte *pte;
+
+	if (!domain->msi_root)
+		return;
+
+	scoped_guard(raw_spinlock_irqsave, &domain->msi_lock) {
+		if (refcount_dec_and_test(&domain->msi_pte_counts[idx])) {
+			pte = &domain->msi_root[idx];
+			riscv_iommu_ir_clear_pte(pte);
+			riscv_iommu_ir_msitbl_inval(domain, pte);
+		}
+	}
+}
+
+static size_t riscv_iommu_ir_get_msipte_idx_from_target(struct riscv_iommu_domain *domain,
+							struct irq_data *data, phys_addr_t *addr)
+{
+	struct msi_msg msg;
+
+	BUG_ON(irq_chip_compose_msi_msg(data, &msg));
+
+	*addr = ((phys_addr_t)msg.address_hi << 32) | msg.address_lo;
+
+	return riscv_iommu_ir_compute_msipte_idx(domain, *addr);
+}
+
+static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
+					   const struct cpumask *dest, bool force)
+{
+	struct riscv_iommu_info *info = data->domain->host_data;
+	struct riscv_iommu_domain *domain = info->domain;
+	phys_addr_t old_addr, new_addr;
+	size_t old_idx, new_idx;
+	int ret;
+
+	old_idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &old_addr);
+
+	ret = irq_chip_set_affinity_parent(data, dest, force);
+	if (ret < 0)
+		return ret;
+
+	new_idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &new_addr);
+
+	if (new_idx == old_idx)
+		return ret;
+
+	riscv_iommu_ir_msitbl_unmap(domain, old_idx);
+	riscv_iommu_ir_msitbl_map(domain, new_idx, new_addr);
+
+	return ret;
+}
+
 static struct irq_chip riscv_iommu_ir_irq_chip = {
 	.name			= "IOMMU-IR",
 	.irq_ack		= irq_chip_ack_parent,
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_affinity	= riscv_iommu_ir_irq_set_affinity,
 };
 
 static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 						unsigned int irq_base, unsigned int nr_irqs,
 						void *arg)
 {
+	struct riscv_iommu_info *info = irqdomain->host_data;
+	struct riscv_iommu_domain *domain = info->domain;
 	struct irq_data *data;
+	phys_addr_t addr;
+	size_t idx;
 	int i, ret;
 
 	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
@@ -171,14 +266,36 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 	for (i = 0; i < nr_irqs; i++) {
 		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
 		data->chip = &riscv_iommu_ir_irq_chip;
+		idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &addr);
+		riscv_iommu_ir_msitbl_map(domain, idx, addr);
 	}
 
 	return 0;
 }
 
+static void riscv_iommu_ir_irq_domain_free_irqs(struct irq_domain *irqdomain,
+						unsigned int irq_base,
+						unsigned int nr_irqs)
+{
+	struct riscv_iommu_info *info = irqdomain->host_data;
+	struct riscv_iommu_domain *domain = info->domain;
+	struct irq_data *data;
+	phys_addr_t addr;
+	size_t idx;
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
+		idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &addr);
+		riscv_iommu_ir_msitbl_unmap(domain, idx);
+	}
+
+	irq_domain_free_irqs_parent(irqdomain, irq_base, nr_irqs);
+}
+
 static const struct irq_domain_ops riscv_iommu_ir_irq_domain_ops = {
 	.alloc = riscv_iommu_ir_irq_domain_alloc_irqs,
-	.free = irq_domain_free_irqs_parent,
+	.free = riscv_iommu_ir_irq_domain_free_irqs,
 };
 
 static const struct msi_parent_ops riscv_iommu_ir_msi_parent_ops = {
@@ -221,6 +338,19 @@ struct irq_domain *riscv_iommu_ir_irq_domain_create(struct riscv_iommu_device *i
 		return NULL;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT) {
+		/*
+		 * NOTE: The RISC-V IOMMU doesn't actually support isolated MSI because
+		 * there is no MSI message validation (see the comment above
+		 * msi_device_has_isolated_msi()). However, we claim isolated MSI here
+		 * because applying the IOMMU ensures MSI messages may only be delivered
+		 * to the mapped MSI addresses. This allows MSIs to be isolated to
+		 * particular harts/vcpus where the unvalidated MSI messages can be
+		 * tolerated.
+		 */
+		irqdomain->flags |= IRQ_DOMAIN_FLAG_ISOLATED_MSI;
+	}
+
 	irqdomain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
 	irqdomain->msi_parent_ops = &riscv_iommu_ir_msi_parent_ops;
 	irq_domain_update_bus_token(irqdomain, DOMAIN_BUS_MSI_REMAP);
@@ -233,6 +363,7 @@ struct irq_domain *riscv_iommu_ir_irq_domain_create(struct riscv_iommu_device *i
 static void riscv_iommu_ir_free_msi_table(struct riscv_iommu_domain *domain)
 {
 	iommu_free_pages(domain->msi_root);
+	kfree(domain->msi_pte_counts);
 }
 
 void riscv_iommu_ir_irq_domain_remove(struct riscv_iommu_info *info)
@@ -274,6 +405,14 @@ static int riscv_ir_set_imsic_global_config(struct riscv_iommu_device *iommu,
 							     nr_ptes * sizeof(*domain->msi_root));
 		if (!domain->msi_root)
 			return -ENOMEM;
+
+		domain->msi_pte_counts = kcalloc(nr_ptes, sizeof(refcount_t), GFP_KERNEL_ACCOUNT);
+		if (!domain->msi_pte_counts) {
+			iommu_free_pages(domain->msi_root);
+			return -ENOMEM;
+		}
+
+		raw_spin_lock_init(&domain->msi_lock);
 	}
 
 	return 0;
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 1fe35f1210fb..aeb5642f003c 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -34,6 +34,8 @@ struct riscv_iommu_domain {
 	unsigned int pgd_mode;
 	unsigned long *pgd_root;
 	struct riscv_iommu_msipte *msi_root;
+	refcount_t *msi_pte_counts;
+	raw_spinlock_t msi_lock;
 	u64 msi_addr_mask;
 	u64 msi_addr_pattern;
 	u32 group_index_bits;
-- 
2.49.0


