Return-Path: <linux-kernel+bounces-879528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FA3C234F8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD23D404A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80EA2DC321;
	Fri, 31 Oct 2025 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i3SZiSow"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DC2D0637
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761890131; cv=none; b=TxtpghijFxjzB7tE4qYcQbjLOnNfyvfm+ec0OaHB0A8DaT/4U06GezTyhxadsqe84T2JYGhPcGR776XEoCbPXbcp1j4LL3oLwgdBTd8SwSjlIjNIBRBGeE3HXmZcyCI7pIOPe+2hkAuemkkZGqX0ijoVdYHtdh/Uy6JrF3wvzqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761890131; c=relaxed/simple;
	bh=fDWAynXxxMM8wnZgiOP8yS88DMzmiyKLjs9SaH6/bks=;
	h=Mime-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NBJDt5A4M8v3L79KQrLTunWEmZAqpoc/mM9r7iRqxY73gJ75FBe6iYKCdSKqoUJsHeNGrIsdFXwLB+XOtjj7J4RxZfkZi/dnCKcuqptsUVR6senJlnuPKdtD+66yuemIfgBIsGg/QF+Rmo9bH5mqD4uCN0eoQkQkU7TAZxAJ+ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i3SZiSow; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47117f92e32so15486595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761890127; x=1762494927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2uphxqo8Dq0ahPpyMVVXeMkMU/LtFsk0B3ztz4GQpss=;
        b=i3SZiSowfa+Dq7nafzt/p5/cYfAOJ1F60Wy8Rdg/HPJkAPieDw7aawMDLglJtFINzK
         FPI1wQUuj5zIMmUEd3Ovd7aTm4Aec7GXOL9Zu3fDE52rX3/hUKvkozQT55gY088cZE7N
         fpL8qWu6payBdJayXo0GsNTDIUT7zNJrXlTIA76sIa90yuLPgEfKDbZXlN7M07nzBDrK
         ZxLezKEWaPRshI/NzWF4K5YMHNlTLb1cYDIndlI+mO18emMuynRZkRDHP8MSub8Z47go
         Hl8Qm8fC8Diro0aZoLS4791ugtt/q94BCUQlJArd/Iv3YyVk3P/3L3nLKsva/7AbQ9D3
         IP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761890127; x=1762494927;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uphxqo8Dq0ahPpyMVVXeMkMU/LtFsk0B3ztz4GQpss=;
        b=Bf8At3ZFZ8O2cBXBLQm2/HIzQeTUC5YApf2eBFr7C1Quv7XKFOk3aqFEVl/9D0gZbs
         TfBWU/zyicudH2ta76kwwHyZozXdSeveU5CcQjqVi6s9Ocw2+PgqDHSW4DMJz6OnPVMY
         8dyHMCABMOcQTEaMiD3VtRkg5sfYCJOuG4mqniTE8qaCiPJgoyyxw90NQwgGDF2/EZwx
         VYUNeupi2E2mj8HKdCZe4eLYPUwXkbO3DickoCAqaArLNBl7RAKo3NQ2FGDXSsX2DvNt
         8XvvSI4dZjiyklAaFQrgGrUH0MPkzypLRP6Q14MhnUVVHrfmwq+NZVdySlX/Mv5Nt6Dq
         DUjA==
X-Forwarded-Encrypted: i=1; AJvYcCXi1aiSJK/3woWodU/cHXxpPPQ3KoLpewStXi0zcdhMprjKDQcVA2U7+HAN1RI/F5p+kCTgadWgipeK1hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw17tEC4m63OGpQBIlxrnSnRg8/ftSLpizi5msUUxfoyoDg9x7
	qBw8uzgvsenVxadV30lP536lgAUoBPBvw0NOdQx7oXTsCy8qeXScl2wVbJ+OdY/iDQGpwhNvP1+
	KBkffx7OWGQrhNVO69WpDlnB0XrVGIcl7BreFYxSctw==
X-Gm-Gg: ASbGncvJyIE1A9cuONkgi9KVtsBRc0/gV4Kt5hQOfaIhs33SOHMaUAs+yxix3EWq8X0
	8PpWsfVpBNrqbPAaD92RB8MDj6N2c3ckNa9hsUrR6gToRRb368FOxVJKw2Z2XjsqEPKRKT0vW5q
	iV8uoD9uZTtOdDiNtDXglQMM4+/jeK0xL11cQBzWglh7O3nUBoRqUrC95YgWcu7P7O/si1Pep2j
	aegxNTlA1KNvvreDoZA5NRn2fCJ0tvxRs2hwtVS2j5MJ4XSg1/Ol/T8sutGieWod9MspaBpVSOZ
	HtdQsvhi
X-Google-Smtp-Source: AGHT+IGDAX1QJAUds5j8mh9BlGLC/RzUnQ2O+/rvAlteja6L2AmrFOaouCasKY8HaV1blDSmNC2uSsBnfY89IV8MWt8=
X-Received: by 2002:a05:600c:3d93:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-477307c5826mr19478055e9.15.1761890127090; Thu, 30 Oct 2025
 22:55:27 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Oct 2025 22:55:25 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Oct 2025 22:55:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Songtang Liu <liusongtang@bytedance.com>
X-Mailer: git-send-email 2.39.5
X-Original-From: Songtang Liu <liusongtang@bytedance.com>
Date: Thu, 30 Oct 2025 22:55:25 -0700
X-Gm-Features: AWmQ_bmT0mQkM9jWP5x80J13JcQ5hhRJh-KzQJq6kRpJ-yLJjjXwcuhaBH2v7Gs
Message-ID: <CAA=HWd1wtM3QkqLkLC0-GtMNykB22jkd5rSYj=PchKFVT2m+Vg@mail.gmail.com>
Subject: [PATCH v2] iommu/amd: Fix potential out-of-bounds read in iommu_mmio_show
To: joro@8bytes.org, will@kernel.org
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, vasant.hegde@amd.com, 
	dheerajkumar.srivastava@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, liusongtang@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Changes in v2:
 - Add Reviewed-by and Tested-by tags from Dheeraj Kumar Srivastava
---

In iommu_mmio_write(), it validates the user-provided offset with the
check: `iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4`.
This assumes a 4-byte access. However, the corresponding
show handler, iommu_mmio_show(), uses readq() to perform an 8-byte
(64-bit) read.

If a user provides an offset equal to `mmio_phys_end - 4`, the check
passes, and will lead to a 4-byte out-of-bounds read.

Fix this by adjusting the boundary check to use sizeof(u64), which
corresponds to the size of the readq() operation.

Fixes: 7a4ee419e8c1 ("iommu/amd: Add debugfs support to dump IOMMU
MMIO registers")
Signed-off-by: Songtang Liu <liusongtang@bytedance.com>
Reviewed-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 10fa217a71199..20b04996441d6 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -37,7 +37,7 @@ static ssize_t iommu_mmio_write(struct file *filp,
const char __user *ubuf,
 	if (ret)
 		return ret;

-	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - 4) {
+	if (iommu->dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64)) {
 		iommu->dbg_mmio_offset = -1;
 		return  -EINVAL;
 	}
-- 
2.39.5

