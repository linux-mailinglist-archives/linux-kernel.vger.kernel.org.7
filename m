Return-Path: <linux-kernel+bounces-825899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BAB8D111
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42F53AFD5F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EEE2E2840;
	Sat, 20 Sep 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hyVqy17M"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5022DF3DA
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400749; cv=none; b=HIadB6vuETcbO2D5ojE4oeUd4ZaYnwDopgs1Kb0iOdTNCnliA/oOi+wo5VcjXi9FnzL5Jg+mKIrnlsv1ibMHRUyEzbLIbzMamGc9lYlHIf6IbjTzNBXL4x0o+8u39ok2yAvWi2Wp2WulA5ynJZYlA5TddEZlUijBcBCEu9ouP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400749; c=relaxed/simple;
	bh=L4Ep+IlxKlKfQcYtfM7Ox88ty3BpmqbADwu0iQdcKxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/3ONb0W56ypoqstafQBWrx6mJKSZfnHQPhyR+nzDVd9XdGC+SVtJzBnwUMXykc36cuQC5r1EcObOuNK7GNchthX19ee6se+LqBiHP/riwS0RRavVvpBo1/Sn+prMFfqE5vkOGQ735r5ZhU91/1DAAWRrsTsZvQOMTGfBOscfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hyVqy17M; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-4256f0444caso1691115ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400747; x=1759005547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLOgLIfPePBzUWNKI9OUk1ZH4Tzzj3tfMuaJlKPwZCo=;
        b=hyVqy17MBgMMZ8I/dHzoK9xAOziNo0FckFXDRTvkuaehre9j8ybyUll9eNL+TvF7Kw
         kT0wZhzNyaHzMfxYBZFZ3I9xFUJlDx7mU6K0QKC0E945bW37WLOEnXD5EjADpKhEf4gR
         ERiKQTwWUVgrrYiXQwmBDJa4e7nJzeS9FsN8f8OvrK36ceTFELI4DefOPgIcrqovKVSp
         ywusVJyaHgUWYIO6tujfHNql5w9vDtkFsVmK4kIKzB781rmLT2TB0qL0CSmzZ5cBXBx8
         szkTZmEehjD+IeGPOtehiCr+DA6ZB6fGD+NnT4+Y5NCkmzyTy7jVfYfjf+CbAzAVBKs5
         Tq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400747; x=1759005547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLOgLIfPePBzUWNKI9OUk1ZH4Tzzj3tfMuaJlKPwZCo=;
        b=ovZtrfHtNQ+S209rBnRMbsv6JKJ+4xVcmPCd1oZczp4XYS6lUe1HiCahscaVQcV90p
         YFTij6zGVhTb3nfVE7mTym2Z9cnk309WW8mvOxYmHfb+HpD/ET1v7yF+bdbIkVZusUM/
         tqz96zXC00NOyZWOD7NoTy33x1k3pD/fmjdGCFQexOlK2LOX6EmWfqxaAKmhANxkNGf7
         nP1ribpAlKU35Fs0XGLfz6aKTRQZSrT9rm7/Z8/VxtiTDPn5SrkYvLi17e3x34vARqNy
         Edg3upDfa0srl0jmYc/mQUJ48XFUE+kbGkOAJEN+atWYuCVDX2l51BzQ70V4ob662Srr
         mLgg==
X-Forwarded-Encrypted: i=1; AJvYcCUg6hiTPeUnX8q3lSjDmDaH/BgFkWtASADh3iJJ/tlaph9OkWhpaCTwBjQWdLi9+4Te/nhngEdWYMh56xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW5CmkZnS/VttUAXnTrobOsDF7ukYO1xOVt8LyFa7Af0rs7UiE
	cKU8gsC3on92UM0MhbnGe6zn92BeR/GAnOmERciXx6Ft7FhKMqUdFRra9x+AJ6cqTE0=
X-Gm-Gg: ASbGncvpiLGjl2+dYQ/mNnVLUoFd6x7PeGP48uvF3WIf4TF98AOxA2eYg9clJ6Xw2o/
	0LKOqKxGjp0y00s9GK7L8vwFwRbP1ObBLfKcSNfSRp7ybLhbjjbtKW191YvtbITvXKELTRup9Nv
	gVCJWeDaXDpgCTyKc0qeMQ4kgZr1PgaK9F3iXrxCdXd7ISgylJhLnSrycPGNd3SWQ+/WQQeSDYJ
	wZgvG1kudmSb2jLKuOeVsJJkRoG+Xx+ngWSv4wPA9o1gKyJg8g5+KZcIE3SPgS0iZ0hiNeYD2FG
	ZGeDIPjsjqO9TJ6JTXKG9tdngoR57pDx4WslaAPTEHAQXmTv3mL0atSP5rY7Dc0lgArOrjtwKBz
	a9fqu5FAySqV6NSXtXOWlD5s6
X-Google-Smtp-Source: AGHT+IEWlWgkYSGO8sbLjeEJVsqweL0Gl+KFRCXKq/6gJAMJHxAY6N4lyWxDMwaZbg9QR7K4TJrpzg==
X-Received: by 2002:a05:6e02:1a64:b0:423:5293:5739 with SMTP id e9e14a558f8ab-424819748bamr113626355ab.19.1758400746834;
        Sat, 20 Sep 2025 13:39:06 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244a4938b4sm38308745ab.11.2025.09.20.13.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:06 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/18] iommu/riscv: Maintain each irq msitbl index with chip data
Date: Sat, 20 Sep 2025 15:39:01 -0500
Message-ID: <20250920203851.2205115-31-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920203851.2205115-20-ajones@ventanamicro.com>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Track each IRQ's MSI table index in the IRQ's chip data of the IR
irqdomain along with a generation number. This will be necessary
when support for irq-set-vcpu-affinity is added as the msitbl
configuration will change to match the guest. When a configuration
changes then it may no longer be possible to compute the index from
the target address, hence the need to stash it. Also, if an allocated
IRQ is not mapped with irq-set-vcpu-affinity after a configuration
change (which will unmap everything), then we need to avoid
attempting to unmap it at free-irqs time.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu-ir.c | 75 +++++++++++++++++++++++++++++-----
 drivers/iommu/riscv/iommu.h    |  1 +
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-ir.c b/drivers/iommu/riscv/iommu-ir.c
index b97768cac4be..059671f18267 100644
--- a/drivers/iommu/riscv/iommu-ir.c
+++ b/drivers/iommu/riscv/iommu-ir.c
@@ -164,11 +164,42 @@ static void riscv_iommu_ir_msitbl_inval(struct riscv_iommu_domain *domain,
 	rcu_read_unlock();
 }
 
-static void riscv_iommu_ir_msitbl_map(struct riscv_iommu_domain *domain, size_t idx,
-				      phys_addr_t addr)
+struct riscv_iommu_ir_chip_data {
+	size_t idx;
+	u32 config;
+};
+
+static size_t riscv_iommu_ir_irq_msitbl_idx(struct irq_data *data)
+{
+	struct riscv_iommu_ir_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	return chip_data->idx;
+}
+
+static u32 riscv_iommu_ir_irq_msitbl_config(struct irq_data *data)
+{
+	struct riscv_iommu_ir_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	return chip_data->config;
+}
+
+static void riscv_iommu_ir_irq_set_msitbl_info(struct irq_data *data,
+					       size_t idx, u32 config)
+{
+	struct riscv_iommu_ir_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	chip_data->idx = idx;
+	chip_data->config = config;
+}
+
+static void riscv_iommu_ir_msitbl_map(struct riscv_iommu_domain *domain,
+				      struct irq_data *data,
+				      size_t idx, phys_addr_t addr)
 {
 	struct riscv_iommu_msipte *pte;
 
+	riscv_iommu_ir_irq_set_msitbl_info(data, idx, domain->msitbl_config);
+
 	if (!domain->msi_root)
 		return;
 
@@ -186,9 +217,17 @@ static void riscv_iommu_ir_msitbl_map(struct riscv_iommu_domain *domain, size_t
 	}
 }
 
-static void riscv_iommu_ir_msitbl_unmap(struct riscv_iommu_domain *domain, size_t idx)
+static void riscv_iommu_ir_msitbl_unmap(struct riscv_iommu_domain *domain,
+					struct irq_data *data, size_t idx)
 {
 	struct riscv_iommu_msipte *pte;
+	u32 config;
+
+	config = riscv_iommu_ir_irq_msitbl_config(data);
+	riscv_iommu_ir_irq_set_msitbl_info(data, -1, -1);
+
+	if (WARN_ON_ONCE(config != domain->msitbl_config))
+		return;
 
 	if (!domain->msi_root)
 		return;
@@ -219,11 +258,11 @@ static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
 {
 	struct riscv_iommu_info *info = data->domain->host_data;
 	struct riscv_iommu_domain *domain = info->domain;
-	phys_addr_t old_addr, new_addr;
 	size_t old_idx, new_idx;
+	phys_addr_t new_addr;
 	int ret;
 
-	old_idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &old_addr);
+	old_idx = riscv_iommu_ir_irq_msitbl_idx(data);
 
 	ret = irq_chip_set_affinity_parent(data, dest, force);
 	if (ret < 0)
@@ -234,8 +273,8 @@ static int riscv_iommu_ir_irq_set_affinity(struct irq_data *data,
 	if (new_idx == old_idx)
 		return ret;
 
-	riscv_iommu_ir_msitbl_unmap(domain, old_idx);
-	riscv_iommu_ir_msitbl_map(domain, new_idx, new_addr);
+	riscv_iommu_ir_msitbl_unmap(domain, data, old_idx);
+	riscv_iommu_ir_msitbl_map(domain, data, new_idx, new_addr);
 
 	return ret;
 }
@@ -254,11 +293,16 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 {
 	struct riscv_iommu_info *info = irqdomain->host_data;
 	struct riscv_iommu_domain *domain = info->domain;
+	struct riscv_iommu_ir_chip_data *chip_data;
 	struct irq_data *data;
 	phys_addr_t addr;
 	size_t idx;
 	int i, ret;
 
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL_ACCOUNT);
+	if (!chip_data)
+		return -ENOMEM;
+
 	ret = irq_domain_alloc_irqs_parent(irqdomain, irq_base, nr_irqs, arg);
 	if (ret)
 		return ret;
@@ -266,8 +310,9 @@ static int riscv_iommu_ir_irq_domain_alloc_irqs(struct irq_domain *irqdomain,
 	for (i = 0; i < nr_irqs; i++) {
 		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
 		data->chip = &riscv_iommu_ir_irq_chip;
+		data->chip_data = chip_data;
 		idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &addr);
-		riscv_iommu_ir_msitbl_map(domain, idx, addr);
+		riscv_iommu_ir_msitbl_map(domain, data, idx, addr);
 	}
 
 	return 0;
@@ -280,14 +325,22 @@ static void riscv_iommu_ir_irq_domain_free_irqs(struct irq_domain *irqdomain,
 	struct riscv_iommu_info *info = irqdomain->host_data;
 	struct riscv_iommu_domain *domain = info->domain;
 	struct irq_data *data;
-	phys_addr_t addr;
+	u32 config;
 	size_t idx;
 	int i;
 
 	for (i = 0; i < nr_irqs; i++) {
 		data = irq_domain_get_irq_data(irqdomain, irq_base + i);
-		idx = riscv_iommu_ir_get_msipte_idx_from_target(domain, data, &addr);
-		riscv_iommu_ir_msitbl_unmap(domain, idx);
+		config = riscv_iommu_ir_irq_msitbl_config(data);
+		/*
+		 * Only irqs with matching config versions need to be unmapped here
+		 * since config changes will unmap everything.
+		 */
+		if (config == domain->msitbl_config) {
+			idx = riscv_iommu_ir_irq_msitbl_idx(data);
+			riscv_iommu_ir_msitbl_unmap(domain, data, idx);
+		}
+		kfree(data->chip_data);
 	}
 
 	irq_domain_free_irqs_parent(irqdomain, irq_base, nr_irqs);
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index aeb5642f003c..130f82e8392a 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -36,6 +36,7 @@ struct riscv_iommu_domain {
 	struct riscv_iommu_msipte *msi_root;
 	refcount_t *msi_pte_counts;
 	raw_spinlock_t msi_lock;
+	u32 msitbl_config;
 	u64 msi_addr_mask;
 	u64 msi_addr_pattern;
 	u32 group_index_bits;
-- 
2.49.0


