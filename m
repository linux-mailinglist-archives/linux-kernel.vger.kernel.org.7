Return-Path: <linux-kernel+bounces-890922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443BC41649
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594FC1899162
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396782D7810;
	Fri,  7 Nov 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eN4G8/Pt"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F726CE3F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542565; cv=none; b=uliqRD8NgwjD34vGEuT3xFs0pHG8yLY4JS2SJ+xx8LvrQMXSjLc7DCfUhILB8Mkxd1dbYuE/ITbhIXQYygBMq/NO1DnVSVJwxhJmrsUzGFWSTyosp6aygfweh93MbgNqTuqu0vevcVPHaaV4PcSSVnGUHSXKXTM8RVLqsl4LcYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542565; c=relaxed/simple;
	bh=Jio0dLTMHWuJSbVzrU/hSMiGj/f2giYmy7YHRCXWFCk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ljXzqA8Fn1e5K3dHxOYOmw28RKwWbw6LuA7goEsDhbox2d0zqj80LYhZ8JYqIezTrefjDPc8t34ZIGm4sbVGacRNjsKa1YdqYVuuhhek6NPYM2gKYqea1zsEt0cjyNQViebsrQK+q11it8xbREEW5Sw6+9AjE12BD8IFcxFMGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tzukui.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eN4G8/Pt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tzukui.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b8f8e1f1044so1733162a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762542563; x=1763147363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0NVzA0RssgZmBwPsMPQrXHwqZYSq1RpFtucbk/ffCh4=;
        b=eN4G8/PtR/ZBgS+FbJb5VWo6XeurcZv36ZnFNjgZ2ETdhucnrYEgv6B0cbPYTSZILA
         t99bTN7aym6vvMBWMr7uF04+7NYC57W591uWr66cYnRaw/tWDtKSUXqNDBoWb/QHRXMq
         F65Cs5F5qQhnd46DuriHdzT96C/suzq+o0BGWPo/u9bgzNhKdkzOAgsz6Y90Qu9fCUcz
         Gibo6n5j/oy7m8m9Th0tGvIg2PduR1Bidhj3yK0CmsDfsMkaGWMgN/eCFIhIToWEy13n
         XDSeXgFIC+9t3yMbln5O311EQaEbzZ19aEIjbaaNB3eDzGRxdxYi3Ht5M79DGTQZlGN1
         Sgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542563; x=1763147363;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0NVzA0RssgZmBwPsMPQrXHwqZYSq1RpFtucbk/ffCh4=;
        b=uoinWgMLUAcm1ECmpO3TdBSGz8BSGsTNOWCgZb/RajlVoXSI57wey5HEFruYQ9ny+O
         sM7I/Khv6xxaMWPhJazrf4rmo8lzOTDpdUZezivMqm8cs6jG4JUvji8UGLxPXR7BAOGW
         7A32XlLEUJAL5aiws//1DKjg7G6oJ3wrRHrcq+AcolfpQwgb31KJpxNsh75z6xSFPSdf
         AYYMaZXD+6IDj22elHoy3suNP/IIcYgRXDgVDMjhEx5pAhQUg0XaP14rrXxNmGyTz43w
         KDGB1TPg/qjnsfBxPYFkAwY0PPEXIrsSyjBpSHltrnc+s2cksoxAur77xmNbopqR9fKN
         cYYA==
X-Forwarded-Encrypted: i=1; AJvYcCVmPHT5pPGdrrbmTBB3qyo2SBtn9jRCwb4FqYcbmufc+khDxguKhU/OIvLplasr0b/QQFdOI9tfs6uJb1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhP/kD4ZDj0GYsw9LE5DvJmc/X1iEmFlTM01GA45gLDH6pFvC/
	IJ+XSC5guCucMX6ZNCqSYQX6zlHwuks9P+OTVVErHcKyU9tsOBkYt5WjC8j+uRpZeEFJGchP11K
	kntBu3Q==
X-Google-Smtp-Source: AGHT+IERV/3DbTV3WeqT5ErpZeSNkgmJgFP4LV8NkvrM2+uwaUCdMTQHV1trZquhgmdySuzjgVBwK8cSeuo=
X-Received: from ploc8.prod.google.com ([2002:a17:902:8488:b0:290:b156:3774])
 (user=tzukui job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:297:d6c0:90b3
 with SMTP id d9443c01a7336-297e564e7b0mr2374475ad.23.1762542563521; Fri, 07
 Nov 2025 11:09:23 -0800 (PST)
Date: Fri,  7 Nov 2025 11:09:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107190917.2858684-1-tzukui@google.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix error check in arm_smmu_alloc_cd_tables
From: Ryan Huang <tzukui@google.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ryan Huang <tzukui@google.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

In arm_smmu_alloc_cd_tables(), the error check following the
dma_alloc_coherent() for cd_table->l2.l1tab incorrectly tests
cd_table->l2.l2ptrs.

This means an allocation failure for l1tab goes undetected, causing
the function to return 0 (success) erroneously.

Correct the check to test cd_table->l2.l1tab.

Fixes: e3b1be2e73db ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
Signed-off-by: Ryan Huang <tzukui@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f0..9780f40ba3e6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1464,7 +1464,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 		cd_table->l2.l1tab = dma_alloc_coherent(smmu->dev, l1size,
 							&cd_table->cdtab_dma,
 							GFP_KERNEL);
-		if (!cd_table->l2.l2ptrs) {
+		if (!cd_table->l2.l1tab) {
 			ret = -ENOMEM;
 			goto err_free_l2ptrs;
 		}
-- 
2.51.2.1041.gc1ab5b90ca-goog


