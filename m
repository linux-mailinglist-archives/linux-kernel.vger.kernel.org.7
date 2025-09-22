Return-Path: <linux-kernel+bounces-826929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3AB8FAAC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A421217DDED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825B28507C;
	Mon, 22 Sep 2025 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5efvkB3"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8B283FE4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531609; cv=none; b=JgKZACRM3aCeReXcb4Bn2J1eeXaN1/c9kBemhan4hS3Y94rVHegSaR30qMvd+lUj9FBSEk5r8yZoDvnBIj0HWj5mhOLXFIyxtlAYjImszZrUad6//NbV33LHR6yYUA6W6IBOTrnTSZV7VqeLBizfaImBtAER3+wQtUwBqwTpspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531609; c=relaxed/simple;
	bh=IkvFohIT4Wev3CJlOkrieSRHtDFSjhkdcyilBtxGyoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZuB/va9OM5+Iomo9y7fndOhBYBSEDm0bVpeUCyRate5Wb+BTiyzv3RPAXqLAvStiswVz6ZKXhh7hPcpKfbnnmb7BaZXBWyzf/k1blJBtkwmNDyxx8N8i0BcuXO5RQQA6K+vX8VtwPGXIvo9cusCAYMbKeJw3OQqqcuGod84Kydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5efvkB3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so36653375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758531606; x=1759136406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dta3w9x0Kzr2/YC3aAI2cLcS4FTvsApb1bOklp+8AkE=;
        b=T5efvkB3e9XLqlhyb/XKnM6NZNWA3wIxaVT9ze3TZdGJ7ILCHqILOIHrIG0qkbmumU
         XpII4vofk5P+EDKr7HewHbuBhiBTSq6NO4vW6q+DA7es/4N4q5Jwytkk53j+i5ELFHwI
         A+C8T/nKQMBZbDM+ZgeNXQl0KQTfj2J07JIKhuV/kK03qKapnvfRpQvVy7C6RKPZNQFl
         BUASWw7e4XvkCo5tF6Ng7vA+MdT/0erG8DMsXsMc9d2Y4kfI4Jud232p+/dEjAlb/nGs
         kPivSeYbZ6da/qr+0R/mYCoQjbsRvi73H8PpR0zV3NOw55U4SAFc5GacS0k5dNHvb0cC
         k1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531606; x=1759136406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dta3w9x0Kzr2/YC3aAI2cLcS4FTvsApb1bOklp+8AkE=;
        b=F/IP5SzUwt9CycWYsoBZymn76HI9D5ZZBbnOSu5pMNFAkUOF02vKqelNv4BVt6QRHk
         Zh/DEn1ZEl25gZyJGa5SDE3C7DthohBv+S2BFsuInhvJabYkQ7BTm2uMhDQY7Fh7Zow1
         q5lCNTa4jmNY3zuUKdgqxS79wcZgfdzGGtKUYZNzDiv1mSNAl7KMe9V4JaW9rYVS3RaP
         Qx4BiROvFYO5kaS2XgGkKzJMIOu8cf9lXy4zfk36SmmLCP3IJB11NCgwt99VT+W5MyeR
         57UxNDgObVNv5gTJ90yGbqYMmy9Pf6QGMbkznqCAs4eHZGkseGcClMv0+v37XOw4iHGu
         fNYg==
X-Forwarded-Encrypted: i=1; AJvYcCUMA3SUO+lV/5fTLIhAjql+Y47M68Bief6XdYmUYxTwhro0FtvjHJkbIg4fNtGgVzYVCV6XoPcIm4NV1Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIKfEMxF16G9Mbyal6fEGgRHX3ZgChI+MaM6d8WONPbtJ6Nim
	ckfsSNUhOtBkgza3lvl5M3KMA/RbuKAcvWRwCGioCOj0gr4w8UzZsUvCcmkbuYcg/RGQKvxhnSx
	SIh8BTMskPzMing==
X-Google-Smtp-Source: AGHT+IEqtivvAp1LSR1yfY3OPo8H0NhHHFJcQpxkNow9ciOTTfMvMKV71pcO7sOl6lYxK9wepfDZCsUMSsF6Iw==
X-Received: from wmbep17.prod.google.com ([2002:a05:600c:8411:b0:45d:d179:882f])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc6:b0:46e:1aa8:44a3 with SMTP id 5b1f17b1804b1-46e1aa845c9mr2814975e9.37.1758531606327;
 Mon, 22 Sep 2025 02:00:06 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:59:25 +0000
In-Reply-To: <20250922090003.686704-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250922090003.686704-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250922090003.686704-2-smostafa@google.com>
Subject: [PATCH v4 1/4] iommu/io-pgtable-arm: Simplify error prints for selftests
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


