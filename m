Return-Path: <linux-kernel+bounces-831861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEC9B9DB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E3E3A18AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9086359;
	Thu, 25 Sep 2025 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOErJtPt"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6414AD20
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782707; cv=none; b=XTspGb98ruxf1wo3cKDsACPyoddBEOr9QMPhYLO1RGRYSS12A6evsN1vJOCBuBcPc/oMSd1ggOtvqHiTVPwJxXz8M7YvezgUQgl08VIeVm0kChZ+Dp8kSdZYpAPhzfmB5A4vbx6RxP2hyjNL50Y8dfED5bf7E3MHmaHpVl9f+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782707; c=relaxed/simple;
	bh=bbqdLAvx27nbu3tvSbwfNO0qFRmAy4gvrfSqHxZwiK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgOMs5wR8hZrobVD0YIdO1tURqxTTkg4H2Ir5sgFtXNuRDGVYJWgCCgDpG7bEM+D/XEqzWsmBLLes9l70faqR7c+aydE0D81DmiVkYRaBOFt1//8Qup5BAbha9JdMy+WmQUXJ4fzaOQws9gT5RUZ/cni976geRqVk8zaXQQPKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOErJtPt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-780f6632e64so352458b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758782705; x=1759387505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwRwggwBb3rmsP7hAuRkEzNpFvdy0j6v2pW8m7D4xoA=;
        b=BOErJtPtPIlL50AlEKWQF5O9rzjcHibYvL4dcE7QWM5k1kSnVFI3wOJk7zIcwAAqTk
         V7sk8fThZqOgJeVh01vDBL09eiD5rBW1ooD4LxYimxK8OPiNBDy/nVqTdaV6l0U5DKPh
         R+MVjYxn4xLMum5EgLASY03UnRUaNmQx+Mxt4I800Y21zPUVQwW1ueg3Oa0pThcProO6
         uQiG6/Bz8vXDdAzPM3XIHV5YUDj0Fan00wxsw0RbzzORgjnChsvHu7yk/gNu/eIWzgLM
         zL1X0Bn+xtzMpVmUrvbT/opvCqSkq2MRQwvuU4fg7Fm1/boKFxd8FREDPd75+W74RDnC
         IP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782705; x=1759387505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwRwggwBb3rmsP7hAuRkEzNpFvdy0j6v2pW8m7D4xoA=;
        b=KDP6nGAM8H6QGA6AFN1mAtqPYRI11LeoKrRRIg5kG1+0RbiMWyJh/UnkIZRKsA98FL
         6HAGYcaOznovlX/0sjFSe7XCJkmlZzGeRuaTq/R6OJUe+ycuQOmazCG7INC7hlaxNiYl
         l5mpXYCjn6xMIlWLcuy+MascUkZceKb/+xdunRY6xi/AHEarAr2l2Ec8CHtr1zpAvQbO
         NOb6TtYfN+u6fG4FJyLzXl8Hncj+uxBfIb6x6JtDX1sJXZRdCZPlMop+gbGKjkZp59nO
         pvq03IFkUW37GRn7m6XGoBWZj0KoDmFx0ECOX1HvT/mog5fYx/XUX3+WrdHlkvrVgBHr
         3tBg==
X-Forwarded-Encrypted: i=1; AJvYcCXAKQuuqaPnaOWj+1cJtbLh+e4grBCxFEgNif2YR7r/x6gKsCkJmP67+psqVI1a/4njc6ARUfwrvEbzQEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIQR84WkME49suTXRDkY5Gra9rSyu9IhZgLPH0vso92duMA78
	rPFd2npoMy7dXIRItNpfqVYDogXT60BLTVCs01CcQcu7tS17/X2Ivd/a
X-Gm-Gg: ASbGnctPXU/nkea9bvAX6Zqar3omINrtP90im3o89v5avfGHREUwDObQQYiQegVTdwm
	Xmatue6kU0Apu3+dPamNBVEtlT/U55BDfrNHUvII3iCPyjAAi54JqanmFIswLCTxlAfoxT/Wnqs
	7GschUkVBbLtl5FNnhvn3FhJXF0DINHk9kROMd63FfLUWgc79S35gq1OfANAu0DK1el898BfnW7
	D2rvOkMPkAHBxzOrIwMGJApUlfzkOZ4fnV1KWknyLjinFb1j7swh8rvrxDcEb6kHlSVVO1oDVW0
	iLkENE0cxmPLNIY0vmDv7PYh82ZYv7mwhfb6bjfmsVeiRcZV1TyRcZRlj/eJCkT5IPklS8TU54b
	JeKLkcrkBaWOWHKEPf4E1fRavRfC2M1AqwvE=
X-Google-Smtp-Source: AGHT+IHt19jtOEnBkeB66T1h510FySIpowgoYjHbNvNGdh2zxGfDHDDIanQQL8ZzNs+QeMAQPJrNJg==
X-Received: by 2002:a17:902:ebc8:b0:271:6af4:15c with SMTP id d9443c01a7336-27ed4a91a97mr31723675ad.36.1758782705016;
        Wed, 24 Sep 2025 23:45:05 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:1f22:92a4:6034:d4c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ad21e9sm13507665ad.144.2025.09.24.23.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:45:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Santosh Sivaraj <santosh@fossix.org>,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails in ndtest_probe()
Date: Thu, 25 Sep 2025 14:44:48 +0800
Message-ID: <20250925064448.1908583-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kcalloc() may fail. ndtest_probe() allocates three DMA address
arrays (dcr_dma, label_dma, dimm_dma) and later unconditionally uses
them in ndtest_nvdimm_init(), which can lead to a NULL pointer
dereference under low-memory conditions.

Check all three allocations and return -ENOMEM if any allocation fails,
jumping to the common error path. Do not emit an extra error message
since the allocator already warns on allocation failure.

Fixes: 9399ab61ad82 ("ndtest: Add dimms to the two buses")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
changelog:
v3:
- Add NULL checks for all three devm_kcalloc() calls and goto the common
  error label on failure.

v2:
- Drop pr_err() on allocation failure; only NULL-check and return -ENOMEM.
- No other changes.
---
 tools/testing/nvdimm/test/ndtest.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 68a064ce598c..8e3b6be53839 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -850,11 +850,22 @@ static int ndtest_probe(struct platform_device *pdev)
 
 	p->dcr_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				 sizeof(dma_addr_t), GFP_KERNEL);
+	if (!p->dcr_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	p->label_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				   sizeof(dma_addr_t), GFP_KERNEL);
+	if (!p->label_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				  sizeof(dma_addr_t), GFP_KERNEL);
-
+	if (!p->dimm_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	rc = ndtest_nvdimm_init(p);
 	if (rc)
 		goto err;
-- 
2.43.0


