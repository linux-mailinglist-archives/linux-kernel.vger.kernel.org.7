Return-Path: <linux-kernel+bounces-824622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7586B89B00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3069416F35C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B55330EF9A;
	Fri, 19 Sep 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xa4ywCLl"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38319DF4A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288803; cv=none; b=V09fL4a5QFpVeyThE/mhc8cgB9Nt2bBUNCBW/0tBQlE3+RRMiHUPG9Iz52xP8Avvpe+7L0+bC3Ekx6c9m71anfHa3bI7f/r1yTONsJxBdbDYrdw3CiXgD7sjJyxO7bYNwBpHTZxMvuCI4VwGN8dCXBH4UcYATE6DaT5b7GZP950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288803; c=relaxed/simple;
	bh=IkvFohIT4Wev3CJlOkrieSRHtDFSjhkdcyilBtxGyoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uVqJwC8HqgDsqeZeNBPL82m1McWQkCrEi4qcD8SR4dzWzG1+KqPHUCr68Iz9FZKuU1bRdOEu5jANPD2lfQ4RK9K6uzaCdxEvfxev2e8nrWFaugd2KhFc8DynucHo80HvxZxU+9E0Pz6cIWfddKJ58zRXHzpuXVM/y/h3EZO2FVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xa4ywCLl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45df7e734e0so23812335e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758288800; x=1758893600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dta3w9x0Kzr2/YC3aAI2cLcS4FTvsApb1bOklp+8AkE=;
        b=Xa4ywCLl86yWPUeJdN5ghDcWRjS/G+pHFrSE6kd4/NEFgAo43CassgsPk009F3R5dl
         XJznGdrFedbNSLuVGN5xMdSVSPFKEquN5qqxVQ15XFoGCUrUM9rv/KAIDj4hOe7Chfwi
         1wPQALS7dVuQHejyDcxo5R6D6oeKyLva8+m1eF0/DvoW38L2F+FtiYeKGz2lnF3iHs1C
         MH7nEX/OvXXPz8lB4U73rWB5+kq258CKZakggOH1a86Nx9lR5ho8ukap/vqDRQGqDBcJ
         TPmZxyJzW4dkpVReTihRll63MEyVXNaa4quM5EpPvqcG7iLmZQ7dRWbsHczLkjXJJm00
         eD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758288800; x=1758893600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dta3w9x0Kzr2/YC3aAI2cLcS4FTvsApb1bOklp+8AkE=;
        b=e0x2VcIawpnPEaJHxxrHOzxNnAGDHQnCjetg1MYglfPx+aUI9JTNRRHjh6Wey7OglT
         RI6Kw/BF/dYVvtnKT+RDjAyaP/VR1hfEM8SI4VDWmeY7nFFLBzIycGoLU0Qwv4HS5xXk
         yMx2bINjq5Efgi365oBF8t0p1wUd31+7ppBfnY9HN4G6QMt7dTbhiJnIOutH6qxIbU0N
         n8hKUKByK9p4Q1JTq7mnRJrcmE9OsajufJXqYxDv0ZoyP6RhkSQ/iLp3kHIV8xxLgPKB
         zfgrRM4yTVl7g85g6kN+tyTJwjVTB1syQO7MrBuH0xhf5UM5oY3CsG+78uM+CqKpdstp
         9S9w==
X-Forwarded-Encrypted: i=1; AJvYcCW2Mb7FpM/99YlKWfo3iYREH7vnO40A6cpVrqd04dAtUadvG00zaRvpbEccUDQitqaoCX+1D1J65ldGm3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAY4zxPFiD6PVpo0Dzrs5LEyAcdpiwSm/p/YGpgsqcpfNFROnL
	TloUxou4WNa09nouSc428jrBDz02GKY/RJwy6mFlBFdmlzK7b9kYuaIgbJeAaT6D0bUmhIQgQsU
	RES7lr1yPHgVpkQ==
X-Google-Smtp-Source: AGHT+IEfxiQvwNODoSv0Q8MyC2iij/p4VeQe4Qd7UQdXLmJ90VPgVJBy+TPvBsuyLaP4UaVBUz+AHld+iqa7Dg==
X-Received: from wmbdr20.prod.google.com ([2002:a05:600c:6094:b0:45c:b62f:ca0d])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:450a:b0:45e:8e:28bf with SMTP id 5b1f17b1804b1-467eb231105mr25807885e9.28.1758288800565;
 Fri, 19 Sep 2025 06:33:20 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:33:10 +0000
In-Reply-To: <20250919133316.2741279-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919133316.2741279-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250919133316.2741279-2-smostafa@google.com>
Subject: [PATCH v3 1/4] iommu/io-pgtable-arm: Simplify error prints for selftests
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, if the self test fails it prints a lot of information
about the page table (size, levels...) this requires access to many
internals, which has to be exposed in the next patch moving the
tests out.

Instead, we can simplify the print, using ias, oas, pgsize_bitmap
and fmt is enough to identify the failed case, and the rest can
be deduced from the code.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 7e8e2216c294..00218af5d5f7 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1299,14 +1299,10 @@ static const struct iommu_flush_ops dummy_tlb_ops __initconst = {
 
 static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
 {
-	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	struct io_pgtable_cfg *cfg = &io_pgtable_ops_to_pgtable(ops)->cfg;
 
-	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit\n",
-		cfg->pgsize_bitmap, cfg->ias);
-	pr_err("data: %d levels, 0x%zx pgd_size, %u pg_shift, %u bits_per_level, pgd @ %p\n",
-		ARM_LPAE_MAX_LEVELS - data->start_level, ARM_LPAE_PGD_SIZE(data),
-		ilog2(ARM_LPAE_GRANULE(data)), data->bits_per_level, data->pgd);
+	pr_err("cfg: pgsize_bitmap 0x%lx, ias %u-bit oas %u-bit\n",
+		cfg->pgsize_bitmap, cfg->ias, cfg->oas);
 }
 
 #define __FAIL(ops, i)	({						\
-- 
2.51.0.534.gc79095c0ca-goog


