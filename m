Return-Path: <linux-kernel+bounces-836494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F6BA9DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D801921B10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4B230C105;
	Mon, 29 Sep 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuArhR7A"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58319309F03
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161012; cv=none; b=LyCoIjlBokrZEvcImceqgKb1vfHEpeRnfEbQ3dmGGCRRjx1EaetQps7JdCp5GAM508ZgGhKy90PCb5YCRMjDESMRaQQmtgPAzvYWc7tdK8rscg2iv+i+dKKQQ4EHYLX/L3/WsA6TiG5wZojdI+KqZ7k0nxbmA99D3E+tkNXwEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161012; c=relaxed/simple;
	bh=gtKktn5mD4ClJKXry7SWpVCtKEWHd43jNhA79F/2a/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PVHQPsVmGIPl+5sohVu+e70Rs5ReUyEWzUQ9EuxUFsiFBER4DARloIseIJZDgMhTYOhydl5mE59QEHRDKzC1ouWSHIlBWQzS/CsuE/72ifr4gdjqfOGdbiw9cQwAekYKo8RhqHj630NFW8BFYHRSViOvtLKzSXYO4YyOo0euNq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuArhR7A; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b3d83a7b6d7so97981866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759161008; x=1759765808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpdr13Dtlhg01cWCXIYI35AG1Y3QRBsSx2SpN+S+hFU=;
        b=WuArhR7AL7A9xTTmiO/wdNfok8u/aT26bjtIvTaqtxcwpBs/SI0Rky3wwjrbiUNO2T
         H0AY/7W5K4PcOk2W7MzO2f4SbGTQmj4B+rVVROFfAP/efVTvyMQiVqPKcGv/uGR48qVU
         lk99VzlWeQPw0hPcd5KQrTYAs9bx13glh0u1dRvarsKmtr4PygV9xeUIv8GOf2gb7dYR
         f99wmxLmcGRpv5Rs8mngQ3WgDSnm1AEY8GkUzVsuaDRz5oHGeSrhaq3LZc1oY4cUlZZH
         3+Efg9VzAiQ/HE56lARCSk5sgou6ATPE8HDpWYvzZm0wZRdtBejmKoAtCaZ8qgfNURKw
         gxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161008; x=1759765808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpdr13Dtlhg01cWCXIYI35AG1Y3QRBsSx2SpN+S+hFU=;
        b=mAnBpF04cRzkj+/FJUPHzheAXfXydGJ5Z2uxwbBY0Y/Lx3zQdb/okUgU+iGn0rITKn
         bEUO1diT0zWXqHjcw2MpUcSGj5BvMni4skZX8zEIeydeB/7sR60wybUOIEKo8RRp0BGe
         SCTTnweGL78SERf2joUZyITtyzysRkWhJwxGcKb5S4Nn4Uckjnxx5zhiYlJApnS9bJTk
         w5FCpmiKkqACfEbPMfJ4sWwAKaOdr5mIwPFBh8feaaoyxEn8Nl+FipQluYaoPnPovxMU
         nuM+89+8Q+G8JNorjH+N7mBOfZfHAbqp5WoQ++LexF+WLpeHYDvxI85vHwBZi0KxbEW9
         V34g==
X-Forwarded-Encrypted: i=1; AJvYcCWa2O+0y9MXR0a1WAzseb8xIQFKNsPKJ2s6ylr7LWRWelVl1Fuj37M7mPQdkJ4izSBH7tr+4tS1mE6b7g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM3xY0fRzM74LP99MHtaqvzuI6UnHpzRILOSZrhkGBgvjPbJ9j
	E+xXTWvkp+ibML+5i7kLoC0bpdYgAIeMOAx5sJV+YzG51YhuIc8Z95dWb0IydoGWMpsJom0dpu3
	70oJGuTBicy+2ZQ==
X-Google-Smtp-Source: AGHT+IFx3LiQcFYe261z/EWWagWvnj6dQR302njS+xm6S18t3FOG1/h2C5xa6C/Nr1sj0mZq6rNxxvXG2ayzJg==
X-Received: from ejrn23.prod.google.com ([2002:a17:906:6897:b0:b3c:699c:2f83])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6a0e:b0:b3e:c7d5:4cbb with SMTP id a640c23a62f3a-b3ec7f3d880mr431947266b.35.1759161008650;
 Mon, 29 Sep 2025 08:50:08 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:49:56 +0000
In-Reply-To: <20250929155001.3287719-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250929155001.3287719-1-smostafa@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250929155001.3287719-2-smostafa@google.com>
Subject: [PATCH v5 1/4] iommu/io-pgtable-arm: Simplify error prints for selftests
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

At the moment, if the self test fails it prints a lot of information
about the page table (size, levels...) this requires access to many
internals, which has to be exposed in the next patch moving the
tests out.

Instead, we can simplify the print, using ias, oas, pgsize_bitmap
and fmt is enough to identify the failed case, and the rest can
be deduced from the code.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
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
2.51.0.536.g15c5d4f767-goog


