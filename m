Return-Path: <linux-kernel+bounces-748453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE97AB14176
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298497A90C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58C274B2E;
	Mon, 28 Jul 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbnbmh2B"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2227603F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725219; cv=none; b=thhEYpynPWrVq3OcHU8VUlaQXw4axhPljz+dYKOgt/g+Q1utj8TbJ8rM5mHmonuSPDUWiVkUZwrf94YwBAR4CbSyJQ3OCeMMoHSE/I7Y7yoGoZ8NtEOgZn852g7ofE6bgnvlIPA/candyJ30N+SZAMFYcrI9VM8lxz9VmfPGB60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725219; c=relaxed/simple;
	bh=UTJ3EADZvyzcbEjh8jnX70x0DzecsPLOepqgNDV9XSU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nm8mEOX3X6GjNU9+xmlnWZz+7Bh+6J9vxp7rPGz4Odm+Iu4sEONxaNhtWhbP11vMRNrOwLnffFi2mNx7JwhC/4nDg1+XMyxzpWV/jk4pGrx6h3T48XhL7hKa7ZpC37WfN0sYxK7Wqz89Z7f7ooh6uCWqSPz7KuE+7/dtQGhuVcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbnbmh2B; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so23761105e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725215; x=1754330015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BvG1e0fJMjxnkQJLACi6wiXT8StTWgftpce1YC3FRoc=;
        b=nbnbmh2BV+5F27hPIjkhvZNngWN6Ew2HBI1nlRhWhyxr/BjKyGm0EWvtmaW7y3/NB2
         +C2R17VWg0jTpkZTyqa46Sr3U4Y7aw4nw37AdDpLCt4spcTIFewQoKY1ZdRIVO16tcHn
         20gic+ffVbeaqBsseUrGaosWifgANegy4uLNgJA6h45/WjL7orwQh7WrtXWxf2kZDwnS
         3LtWFRv3mf6GMec3WWswupxkZNebRs4OsRU4qnb8p8OzvpWi+fk3hBwlEDKzz9ClRT3g
         2Ezj0s/AnppqYywvtY7AtScjzk3NLFsXsPH/1055pZnlGHzDwnWJQe816beRSqU0S77O
         M6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725215; x=1754330015;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvG1e0fJMjxnkQJLACi6wiXT8StTWgftpce1YC3FRoc=;
        b=Xo8o7j3hecBmVd2k45hr+r+kRXqYsI1cYjP0hL1GptAu6/GHZKZEkOVS7zY8F9cWBi
         xxUCopN9nt3e9mBaHoOyxpyFKEosDM32qoq0vYQqLayVNEoYyKIjC/iP1yrOUPXYjgfG
         Woz/oLUpAJd6MfTYOhrOe+fFxH8qauyCWv2jPYvUPqsDNhmR8JX8ldz9qjcQFpmxxGRa
         ZKAiYjhzpCxQ+382I0G7hUyR854sOYTPK0/nUyJs2SzwNM5ep6+CwaYxRxLKOMMGAyb/
         RTXMRwerp87vnGZoRbLYXEMVeeQ7PfLSLm34eNW42JPz0e3TDYE7ftkZozVATVJeC/DC
         BXGw==
X-Gm-Message-State: AOJu0YyMm4s03Skt2N4e1h0CH9QyBDc8N6ufZYMdFWDHDTHs+vbX5Xp3
	pJNqTjbRh+0zysPAw27tmCYFvhn94msUhbipqL2DHBNhB/gW630TwAXZvt9P7hJ+J27qi/5iTqk
	+cEjQw1UosegxLmI1IpqQjzxsPQdDWsmxUfw9V2X3wZJN46YyQkyh7dneOLKAoTOU0oqt4v52c5
	yCkYP9YQMVbWuvDCdxAc02IoPUVeDEBTaQzvKOO1C56ZuX4tcZeCTYBss=
X-Google-Smtp-Source: AGHT+IEAErBdYeXW0LItJq+qN9NNCqWM1YWA4pglpketrfa4eKgKL9FwCQdMMGW3DvM5tSjzXGq8+P39WPltuA==
X-Received: from wmbhg22.prod.google.com ([2002:a05:600c:5396:b0:456:e1f:751a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e08:b0:456:11db:2f0f with SMTP id 5b1f17b1804b1-4587f8a9ac5mr78135615e9.16.1753725215187;
 Mon, 28 Jul 2025 10:53:35 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:52:52 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-6-smostafa@google.com>
Subject: [PATCH v3 05/29] iommu/io-pgtable-arm: Split initialization
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Extract the configuration part from io-pgtable-arm.c, move it to
io-pgtable-arm-common.c.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm-common.c | 295 ++++++++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c        | 280 +-----------------------
 drivers/iommu/io-pgtable-arm.h        |   8 +
 3 files changed, 312 insertions(+), 271 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm-common.c b/drivers/iommu/io-pgtable-arm-common.c
index 6d5ae1b340b2..40bd5a6bad88 100644
--- a/drivers/iommu/io-pgtable-arm-common.c
+++ b/drivers/iommu/io-pgtable-arm-common.c
@@ -11,6 +11,301 @@
 
 #include "io-pgtable-arm.h"
 
+/*
+ * Check if concatenated PGDs are mandatory according to Arm DDI0487 (K.a)
+ * 1) R_DXBSH: For 16KB, and 48-bit input size, use level 1 instead of 0.
+ * 2) R_SRKBC: After de-ciphering the table for PA size and valid initial lookup
+ *   a) 40 bits PA size with 4K: use level 1 instead of level 0 (2 tables for ias = oas)
+ *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 tables for ias = oas)
+ *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables for ias = oas)
+ *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables for ias = oas)
+ */
+static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
+					     struct arm_lpae_io_pgtable *data)
+{
+	unsigned int ias = cfg->ias;
+	unsigned int oas = cfg->oas;
+
+	/* Covers 1 and 2.d */
+	if ((ARM_LPAE_GRANULE(data) == SZ_16K) && (data->start_level == 0))
+		return (oas == 48) || (ias == 48);
+
+	/* Covers 2.a and 2.c */
+	if ((ARM_LPAE_GRANULE(data) == SZ_4K) && (data->start_level == 0))
+		return (oas == 40) || (oas == 42);
+
+	/* Case 2.b */
+	return (ARM_LPAE_GRANULE(data) == SZ_16K) &&
+	       (data->start_level == 1) && (oas == 40);
+}
+
+static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
+{
+	unsigned long granule, page_sizes;
+	unsigned int max_addr_bits = 48;
+
+	/*
+	 * We need to restrict the supported page sizes to match the
+	 * translation regime for a particular granule. Aim to match
+	 * the CPU page size if possible, otherwise prefer smaller sizes.
+	 * While we're at it, restrict the block sizes to match the
+	 * chosen granule.
+	 */
+	if (cfg->pgsize_bitmap & PAGE_SIZE)
+		granule = PAGE_SIZE;
+	else if (cfg->pgsize_bitmap & ~PAGE_MASK)
+		granule = 1UL << __fls(cfg->pgsize_bitmap & ~PAGE_MASK);
+	else if (cfg->pgsize_bitmap & PAGE_MASK)
+		granule = 1UL << __ffs(cfg->pgsize_bitmap & PAGE_MASK);
+	else
+		granule = 0;
+
+	switch (granule) {
+	case SZ_4K:
+		page_sizes = (SZ_4K | SZ_2M | SZ_1G);
+		break;
+	case SZ_16K:
+		page_sizes = (SZ_16K | SZ_32M);
+		break;
+	case SZ_64K:
+		max_addr_bits = 52;
+		page_sizes = (SZ_64K | SZ_512M);
+		if (cfg->oas > 48)
+			page_sizes |= 1ULL << 42; /* 4TB */
+		break;
+	default:
+		page_sizes = 0;
+	}
+
+	cfg->pgsize_bitmap &= page_sizes;
+	cfg->ias = min(cfg->ias, max_addr_bits);
+	cfg->oas = min(cfg->oas, max_addr_bits);
+}
+
+int arm_lpae_init_pgtable(struct io_pgtable_cfg *cfg,
+			  struct arm_lpae_io_pgtable *data)
+{
+	int levels, va_bits, pg_shift;
+
+	arm_lpae_restrict_pgsizes(cfg);
+
+	if (!(cfg->pgsize_bitmap & (SZ_4K | SZ_16K | SZ_64K)))
+		return -EINVAL;
+
+	if (cfg->ias > ARM_LPAE_MAX_ADDR_BITS)
+		return E2BIG;
+
+	if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
+		return -E2BIG;
+
+	pg_shift = __ffs(cfg->pgsize_bitmap);
+	data->bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
+
+	va_bits = cfg->ias - pg_shift;
+	levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
+	data->start_level = ARM_LPAE_MAX_LEVELS - levels;
+
+	/* Calculate the actual size of our pgd (without concatenation) */
+	data->pgd_bits = va_bits - (data->bits_per_level * (levels - 1));
+	return 0;
+}
+
+int arm_lpae_init_pgtable_s1(struct io_pgtable_cfg *cfg,
+			     struct arm_lpae_io_pgtable *data,
+			     void *cookie)
+{
+	u64 reg;
+	int ret;
+	typeof(&cfg->arm_lpae_s1_cfg.tcr) tcr = &cfg->arm_lpae_s1_cfg.tcr;
+	bool tg1;
+
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
+			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
+			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
+			    IO_PGTABLE_QUIRK_ARM_HD |
+			    IO_PGTABLE_QUIRK_NO_WARN))
+		return -EINVAL;
+
+	ret = arm_lpae_init_pgtable(cfg, data);
+	if (ret)
+		return ret;
+
+	/* TCR */
+	if (cfg->coherent_walk) {
+		tcr->sh = ARM_LPAE_TCR_SH_IS;
+		tcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
+		tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
+		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
+			return -EINVAL;
+	} else {
+		tcr->sh = ARM_LPAE_TCR_SH_OS;
+		tcr->irgn = ARM_LPAE_TCR_RGN_NC;
+		if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
+			tcr->orgn = ARM_LPAE_TCR_RGN_NC;
+		else
+			tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
+	}
+
+	tg1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1;
+	switch (ARM_LPAE_GRANULE(data)) {
+	case SZ_4K:
+		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_4K : ARM_LPAE_TCR_TG0_4K;
+		break;
+	case SZ_16K:
+		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_16K : ARM_LPAE_TCR_TG0_16K;
+		break;
+	case SZ_64K:
+		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_64K : ARM_LPAE_TCR_TG0_64K;
+		break;
+	}
+
+	switch (cfg->oas) {
+	case 32:
+		tcr->ips = ARM_LPAE_TCR_PS_32_BIT;
+		break;
+	case 36:
+		tcr->ips = ARM_LPAE_TCR_PS_36_BIT;
+		break;
+	case 40:
+		tcr->ips = ARM_LPAE_TCR_PS_40_BIT;
+		break;
+	case 42:
+		tcr->ips = ARM_LPAE_TCR_PS_42_BIT;
+		break;
+	case 44:
+		tcr->ips = ARM_LPAE_TCR_PS_44_BIT;
+		break;
+	case 48:
+		tcr->ips = ARM_LPAE_TCR_PS_48_BIT;
+		break;
+	case 52:
+		tcr->ips = ARM_LPAE_TCR_PS_52_BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tcr->tsz = 64ULL - cfg->ias;
+
+	/* MAIRs */
+	reg = (ARM_LPAE_MAIR_ATTR_NC
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_NC)) |
+	      (ARM_LPAE_MAIR_ATTR_WBRWA
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
+	      (ARM_LPAE_MAIR_ATTR_DEVICE
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV)) |
+	      (ARM_LPAE_MAIR_ATTR_INC_OWBRWA
+	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE));
+
+	cfg->arm_lpae_s1_cfg.mair = reg;
+
+	/* Looking good; allocate a pgd */
+	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
+					   GFP_KERNEL, cfg, cookie);
+	if (!data->pgd)
+		return -ENOMEM;
+
+	/* Ensure the empty pgd is visible before any actual TTBR write */
+	wmb();
+
+	/* TTBR */
+	cfg->arm_lpae_s1_cfg.ttbr = __arm_lpae_virt_to_phys(data->pgd);
+	return 0;
+}
+
+int arm_lpae_init_pgtable_s2(struct io_pgtable_cfg *cfg,
+			     struct arm_lpae_io_pgtable *data,
+			     void *cookie)
+{
+	u64 sl;
+	int ret;
+	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
+
+	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
+			    IO_PGTABLE_QUIRK_NO_WARN))
+		return -EINVAL;
+
+	ret = arm_lpae_init_pgtable(cfg, data);
+	if (ret)
+		return ret;
+
+	if (arm_lpae_concat_mandatory(cfg, data)) {
+		if (WARN_ON((ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte)) >
+			    ARM_LPAE_S2_MAX_CONCAT_PAGES))
+			return -EINVAL;
+		data->pgd_bits += data->bits_per_level;
+		data->start_level++;
+	}
+
+	/* VTCR */
+	if (cfg->coherent_walk) {
+		vtcr->sh = ARM_LPAE_TCR_SH_IS;
+		vtcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
+		vtcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
+	} else {
+		vtcr->sh = ARM_LPAE_TCR_SH_OS;
+		vtcr->irgn = ARM_LPAE_TCR_RGN_NC;
+		vtcr->orgn = ARM_LPAE_TCR_RGN_NC;
+	}
+
+	sl = data->start_level;
+
+	switch (ARM_LPAE_GRANULE(data)) {
+	case SZ_4K:
+		vtcr->tg = ARM_LPAE_TCR_TG0_4K;
+		sl++; /* SL0 format is different for 4K granule size */
+		break;
+	case SZ_16K:
+		vtcr->tg = ARM_LPAE_TCR_TG0_16K;
+		break;
+	case SZ_64K:
+		vtcr->tg = ARM_LPAE_TCR_TG0_64K;
+		break;
+	}
+
+	switch (cfg->oas) {
+	case 32:
+		vtcr->ps = ARM_LPAE_TCR_PS_32_BIT;
+		break;
+	case 36:
+		vtcr->ps = ARM_LPAE_TCR_PS_36_BIT;
+		break;
+	case 40:
+		vtcr->ps = ARM_LPAE_TCR_PS_40_BIT;
+		break;
+	case 42:
+		vtcr->ps = ARM_LPAE_TCR_PS_42_BIT;
+		break;
+	case 44:
+		vtcr->ps = ARM_LPAE_TCR_PS_44_BIT;
+		break;
+	case 48:
+		vtcr->ps = ARM_LPAE_TCR_PS_48_BIT;
+		break;
+	case 52:
+		vtcr->ps = ARM_LPAE_TCR_PS_52_BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vtcr->tsz = 64ULL - cfg->ias;
+	vtcr->sl = ~sl & ARM_LPAE_VTCR_SL0_MASK;
+
+	/* Allocate pgd pages */
+	data->pgd = __arm_lpae_alloc_pages(PAGE_ALIGN(ARM_LPAE_PGD_SIZE(data)),
+					   GFP_KERNEL, cfg, cookie);
+	if (!data->pgd)
+		return -ENOMEM;
+
+	/* Ensure the empty pgd is visible before any actual TTBR write */
+	wmb();
+
+	/* VTTBR */
+	cfg->arm_lpae_s2_cfg.vttbr = __arm_lpae_virt_to_phys(data->pgd);
+	return 0;
+}
+
 /*
  * Convert an index returned by ARM_LPAE_PGD_IDX(), which can point into
  * a concatenated PGD, into the maximum number of entries that can be
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index ca4467ad3c40..dad6964f462a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -36,34 +36,6 @@ void arm_lpae_split_blk(void)
 	WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed");
 }
 
-/*
- * Check if concatenated PGDs are mandatory according to Arm DDI0487 (K.a)
- * 1) R_DXBSH: For 16KB, and 48-bit input size, use level 1 instead of 0.
- * 2) R_SRKBC: After de-ciphering the table for PA size and valid initial lookup
- *   a) 40 bits PA size with 4K: use level 1 instead of level 0 (2 tables for ias = oas)
- *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 tables for ias = oas)
- *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables for ias = oas)
- *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables for ias = oas)
- */
-static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
-					     struct arm_lpae_io_pgtable *data)
-{
-	unsigned int ias = cfg->ias;
-	unsigned int oas = cfg->oas;
-
-	/* Covers 1 and 2.d */
-	if ((ARM_LPAE_GRANULE(data) == SZ_16K) && (data->start_level == 0))
-		return (oas == 48) || (ias == 48);
-
-	/* Covers 2.a and 2.c */
-	if ((ARM_LPAE_GRANULE(data) == SZ_4K) && (data->start_level == 0))
-		return (oas == 40) || (oas == 42);
-
-	/* Case 2.b */
-	return (ARM_LPAE_GRANULE(data) == SZ_16K) &&
-	       (data->start_level == 1) && (oas == 40);
-}
-
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
 {
 	return (dma_addr_t)virt_to_phys(pages);
@@ -317,80 +289,15 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
 	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
 }
 
-static void arm_lpae_restrict_pgsizes(struct io_pgtable_cfg *cfg)
-{
-	unsigned long granule, page_sizes;
-	unsigned int max_addr_bits = 48;
-
-	/*
-	 * We need to restrict the supported page sizes to match the
-	 * translation regime for a particular granule. Aim to match
-	 * the CPU page size if possible, otherwise prefer smaller sizes.
-	 * While we're at it, restrict the block sizes to match the
-	 * chosen granule.
-	 */
-	if (cfg->pgsize_bitmap & PAGE_SIZE)
-		granule = PAGE_SIZE;
-	else if (cfg->pgsize_bitmap & ~PAGE_MASK)
-		granule = 1UL << __fls(cfg->pgsize_bitmap & ~PAGE_MASK);
-	else if (cfg->pgsize_bitmap & PAGE_MASK)
-		granule = 1UL << __ffs(cfg->pgsize_bitmap & PAGE_MASK);
-	else
-		granule = 0;
-
-	switch (granule) {
-	case SZ_4K:
-		page_sizes = (SZ_4K | SZ_2M | SZ_1G);
-		break;
-	case SZ_16K:
-		page_sizes = (SZ_16K | SZ_32M);
-		break;
-	case SZ_64K:
-		max_addr_bits = 52;
-		page_sizes = (SZ_64K | SZ_512M);
-		if (cfg->oas > 48)
-			page_sizes |= 1ULL << 42; /* 4TB */
-		break;
-	default:
-		page_sizes = 0;
-	}
-
-	cfg->pgsize_bitmap &= page_sizes;
-	cfg->ias = min(cfg->ias, max_addr_bits);
-	cfg->oas = min(cfg->oas, max_addr_bits);
-}
-
 static struct arm_lpae_io_pgtable *
 arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 {
 	struct arm_lpae_io_pgtable *data;
-	int levels, va_bits, pg_shift;
-
-	arm_lpae_restrict_pgsizes(cfg);
-
-	if (!(cfg->pgsize_bitmap & (SZ_4K | SZ_16K | SZ_64K)))
-		return NULL;
-
-	if (cfg->ias > ARM_LPAE_MAX_ADDR_BITS)
-		return NULL;
-
-	if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
-		return NULL;
 
 	data = kmalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
 
-	pg_shift = __ffs(cfg->pgsize_bitmap);
-	data->bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
-
-	va_bits = cfg->ias - pg_shift;
-	levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
-	data->start_level = ARM_LPAE_MAX_LEVELS - levels;
-
-	/* Calculate the actual size of our pgd (without concatenation) */
-	data->pgd_bits = va_bits - (data->bits_per_level * (levels - 1));
-
 	data->iop.ops = (struct io_pgtable_ops) {
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
@@ -405,203 +312,31 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 static struct io_pgtable *
 arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 {
-	u64 reg;
 	struct arm_lpae_io_pgtable *data;
-	typeof(&cfg->arm_lpae_s1_cfg.tcr) tcr = &cfg->arm_lpae_s1_cfg.tcr;
-	bool tg1;
-
-	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
-			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
-			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
-			    IO_PGTABLE_QUIRK_ARM_HD |
-			    IO_PGTABLE_QUIRK_NO_WARN))
-		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
 	if (!data)
 		return NULL;
-
-	/* TCR */
-	if (cfg->coherent_walk) {
-		tcr->sh = ARM_LPAE_TCR_SH_IS;
-		tcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
-		tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
-		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
-			goto out_free_data;
-	} else {
-		tcr->sh = ARM_LPAE_TCR_SH_OS;
-		tcr->irgn = ARM_LPAE_TCR_RGN_NC;
-		if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
-			tcr->orgn = ARM_LPAE_TCR_RGN_NC;
-		else
-			tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
-	}
-
-	tg1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_TTBR1;
-	switch (ARM_LPAE_GRANULE(data)) {
-	case SZ_4K:
-		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_4K : ARM_LPAE_TCR_TG0_4K;
-		break;
-	case SZ_16K:
-		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_16K : ARM_LPAE_TCR_TG0_16K;
-		break;
-	case SZ_64K:
-		tcr->tg = tg1 ? ARM_LPAE_TCR_TG1_64K : ARM_LPAE_TCR_TG0_64K;
-		break;
-	}
-
-	switch (cfg->oas) {
-	case 32:
-		tcr->ips = ARM_LPAE_TCR_PS_32_BIT;
-		break;
-	case 36:
-		tcr->ips = ARM_LPAE_TCR_PS_36_BIT;
-		break;
-	case 40:
-		tcr->ips = ARM_LPAE_TCR_PS_40_BIT;
-		break;
-	case 42:
-		tcr->ips = ARM_LPAE_TCR_PS_42_BIT;
-		break;
-	case 44:
-		tcr->ips = ARM_LPAE_TCR_PS_44_BIT;
-		break;
-	case 48:
-		tcr->ips = ARM_LPAE_TCR_PS_48_BIT;
-		break;
-	case 52:
-		tcr->ips = ARM_LPAE_TCR_PS_52_BIT;
-		break;
-	default:
-		goto out_free_data;
+	if (arm_lpae_init_pgtable_s1(cfg, data, cookie)) {
+		kfree(data);
+		return NULL;
 	}
-
-	tcr->tsz = 64ULL - cfg->ias;
-
-	/* MAIRs */
-	reg = (ARM_LPAE_MAIR_ATTR_NC
-	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_NC)) |
-	      (ARM_LPAE_MAIR_ATTR_WBRWA
-	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
-	      (ARM_LPAE_MAIR_ATTR_DEVICE
-	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV)) |
-	      (ARM_LPAE_MAIR_ATTR_INC_OWBRWA
-	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE));
-
-	cfg->arm_lpae_s1_cfg.mair = reg;
-
-	/* Looking good; allocate a pgd */
-	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
-					   GFP_KERNEL, cfg, cookie);
-	if (!data->pgd)
-		goto out_free_data;
-
-	/* Ensure the empty pgd is visible before any actual TTBR write */
-	wmb();
-
-	/* TTBR */
-	cfg->arm_lpae_s1_cfg.ttbr = virt_to_phys(data->pgd);
 	return &data->iop;
-
-out_free_data:
-	kfree(data);
-	return NULL;
 }
 
 static struct io_pgtable *
 arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 {
-	u64 sl;
 	struct arm_lpae_io_pgtable *data;
-	typeof(&cfg->arm_lpae_s2_cfg.vtcr) vtcr = &cfg->arm_lpae_s2_cfg.vtcr;
-
-	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_S2FWB |
-			    IO_PGTABLE_QUIRK_NO_WARN))
-		return NULL;
 
 	data = arm_lpae_alloc_pgtable(cfg);
 	if (!data)
 		return NULL;
-
-	if (arm_lpae_concat_mandatory(cfg, data)) {
-		if (WARN_ON((ARM_LPAE_PGD_SIZE(data) / sizeof(arm_lpae_iopte)) >
-			    ARM_LPAE_S2_MAX_CONCAT_PAGES))
-			return NULL;
-		data->pgd_bits += data->bits_per_level;
-		data->start_level++;
-	}
-
-	/* VTCR */
-	if (cfg->coherent_walk) {
-		vtcr->sh = ARM_LPAE_TCR_SH_IS;
-		vtcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
-		vtcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
-	} else {
-		vtcr->sh = ARM_LPAE_TCR_SH_OS;
-		vtcr->irgn = ARM_LPAE_TCR_RGN_NC;
-		vtcr->orgn = ARM_LPAE_TCR_RGN_NC;
-	}
-
-	sl = data->start_level;
-
-	switch (ARM_LPAE_GRANULE(data)) {
-	case SZ_4K:
-		vtcr->tg = ARM_LPAE_TCR_TG0_4K;
-		sl++; /* SL0 format is different for 4K granule size */
-		break;
-	case SZ_16K:
-		vtcr->tg = ARM_LPAE_TCR_TG0_16K;
-		break;
-	case SZ_64K:
-		vtcr->tg = ARM_LPAE_TCR_TG0_64K;
-		break;
-	}
-
-	switch (cfg->oas) {
-	case 32:
-		vtcr->ps = ARM_LPAE_TCR_PS_32_BIT;
-		break;
-	case 36:
-		vtcr->ps = ARM_LPAE_TCR_PS_36_BIT;
-		break;
-	case 40:
-		vtcr->ps = ARM_LPAE_TCR_PS_40_BIT;
-		break;
-	case 42:
-		vtcr->ps = ARM_LPAE_TCR_PS_42_BIT;
-		break;
-	case 44:
-		vtcr->ps = ARM_LPAE_TCR_PS_44_BIT;
-		break;
-	case 48:
-		vtcr->ps = ARM_LPAE_TCR_PS_48_BIT;
-		break;
-	case 52:
-		vtcr->ps = ARM_LPAE_TCR_PS_52_BIT;
-		break;
-	default:
-		goto out_free_data;
+	if (arm_lpae_init_pgtable_s2(cfg, data, cookie)) {
+		kfree(data);
+		return NULL;
 	}
-
-	vtcr->tsz = 64ULL - cfg->ias;
-	vtcr->sl = ~sl & ARM_LPAE_VTCR_SL0_MASK;
-
-	/* Allocate pgd pages */
-	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
-					   GFP_KERNEL, cfg, cookie);
-	if (!data->pgd)
-		goto out_free_data;
-
-	/* Ensure the empty pgd is visible before any actual TTBR write */
-	wmb();
-
-	/* VTTBR */
-	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd);
 	return &data->iop;
-
-out_free_data:
-	kfree(data);
-	return NULL;
 }
 
 static struct io_pgtable *
@@ -642,6 +377,9 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	if (!data)
 		return NULL;
 
+	if (arm_lpae_init_pgtable(cfg, data))
+		goto out_free_data;
+
 	/* Mali seems to need a full 4-level table regardless of IAS */
 	if (data->start_level > 0) {
 		data->start_level = 0;
diff --git a/drivers/iommu/io-pgtable-arm.h b/drivers/iommu/io-pgtable-arm.h
index c3a3b4fd44c3..2807cf563f11 100644
--- a/drivers/iommu/io-pgtable-arm.h
+++ b/drivers/iommu/io-pgtable-arm.h
@@ -230,4 +230,12 @@ void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
 			     arm_lpae_iopte *ptep);
 void arm_lpae_split_blk(void);
+int arm_lpae_init_pgtable(struct io_pgtable_cfg *cfg,
+			  struct arm_lpae_io_pgtable *data);
+int arm_lpae_init_pgtable_s1(struct io_pgtable_cfg *cfg,
+			     struct arm_lpae_io_pgtable *data,
+			     void *cookie);
+int arm_lpae_init_pgtable_s2(struct io_pgtable_cfg *cfg,
+			     struct arm_lpae_io_pgtable *data,
+			     void *cookie);
 #endif /* IO_PGTABLE_H_ */
\ No newline at end of file
-- 
2.50.1.552.g942d659e1b-goog


