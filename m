Return-Path: <linux-kernel+bounces-825891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1C8B8D0E3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C0B7AF81C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AFE2DA755;
	Sat, 20 Sep 2025 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NCFjqLPA"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4A2D46B7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400739; cv=none; b=Zz4d9pGlP8B+cAf+odSK44ZvFbc8Ap3BCx2gQJdLwEOopvk4r7+MMRWEGGMNRjLl//tbJUxfpSnr2w++NdvxD/PL7tSzu5zcXYZivr19Bk9QosaLdote6gUDwCm/vaGupzQHBv2sJcs9BidFZQ1sGS1F65eePtuWyOmGg4M2xIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400739; c=relaxed/simple;
	bh=FYh0M9S8lqaZUVwPflZkoaMdoFI/RTpU9RBLhPrKLAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuhHVYri+UN+yO2vAH9lwXSzeTfhOd50hISRkNAvQ0yzesrWVKTCDR2iDohp1iyKygH7Gjuchqf4uCqQTiFL7qQyJfNWlMyrQHJ47itF9FhRvL1xeqUZceygo5xNCFihEsbWawAGDLd+dFGMPACuCRzVsHXIXKHbFYlA+8rlvuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NCFjqLPA; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-425715aeccdso835725ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400737; x=1759005537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZPFm4Y9icCAth6wrzJMUkgkEfNQH2w/TjaKN8QVYFg=;
        b=NCFjqLPALOloAVzUjH0FzfGwV7HQtcNgmftLwH++KYH4OzYITjSO7ZMS5pjRBeU9DH
         4nqgwTJwkVLFg2VzLva5tREIxlUqqdOM0uYEjXf0hw6kjzQ8nedW8di6T/yNc8gVNQw9
         eID6haNH40RVuddTdVflYuTuPrTblXADgVbDYBHS+H+oqqgZdd/VcYzfO3VzallbHSDI
         vz2WAy4jfRKftp+7z4qHXCV+jrWrBdifGM6JSJmdTUOfOmCVstaLb8AFNAx4z2oi+Mx/
         5+xfSK1oZkPz6rNTaWbxS9jTMpctX0+LWqSqn7N2jHC8jYWmWXc2NFGkeyJa2zCTmv7u
         +T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400737; x=1759005537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZPFm4Y9icCAth6wrzJMUkgkEfNQH2w/TjaKN8QVYFg=;
        b=bEP+MyLNDumSZ3917RgE52vCxKDAhI+hk/zzC9+39dGmdJjPUwXPk2pIpjBXTdwHCL
         Ff3gyyh0iNr6phlu1FxmRPSahh5qKoj6ZQQTTOqmfYO2EOofdGtcK0CNoZ1HOzvWOY5S
         T3lxSZp1Rb6eH4Zm0oR+GUbPpBp1kmhPzaqQCZJ4bzwZ5gvcGQ09NpS/P+9KFBtb+B5r
         dalK7yUWVrmxzxKAEOruE6/tYUXTwlA8NqjZ8/eAZ9Y7NmaZk2ZVcd3qkVweiqr7ZnDQ
         pJOYERO1EoD3Ps2OhHnRMDgtLSD3oKDgrwQdKyvCibLrYvP0Dqq4WOx7euFmcSXaw7mn
         Yo4A==
X-Forwarded-Encrypted: i=1; AJvYcCX4qWYZu8Hzc8TAEsPZDdmaa0RFHAd8QhQotcbw4D9gFqQwtv0bNxnj0NHEOV7hthZvaZ0krefp7XiQhug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfKqQRfkPAC2r3ZisqN6+9oCX7Bgme9qedoXdsM0BOsV2feZDO
	yW7PsBFe1q4as8OfKcQ8BEprTqqOloJjOnIUBWbr40Ggvy94KkRJ4/s6NM74W4c9LFc=
X-Gm-Gg: ASbGncsblNW4qzLr8vuKVGQTcBDi9OV6ULhxZ8841Sjr1oUKeoalvSwO/LpNwQC05fg
	7XqqVYqK9pTlgSW4WpIPyqTYaxcX8gZtL9tVP5LXhKJvfXdykIZQAVJFqOAVp0GP0S9i8CmxKaM
	ocI73SZAiWzdR43zlUzRLRtIw52u4A3f+BrmvxTtOi8ghX6thuiXbyiex5rU8TwjXKiC+atuDqz
	5QQtD5/RcZBu6m40+7p1B5DheVjHz+blQyJTFD7KpSlv5jf7hoQwcSE2asNhZly0dXNBOTKe80g
	a3KxkSwTzFpIPmdnvCpU82CH7ijaPKm5NRHDfSl4DM0p57dQTc8KezY9z6pze2aXHoF4gnMgdkQ
	rRwDTBiyQKNYyQbDJ+jRt5NNm
X-Google-Smtp-Source: AGHT+IFXBb6vr/8D7CZ5otepQnRcmkVx5TB79A7j3YsaSno67UMLJAS4DCtxM6o0ZN+HnZGFA1J8HQ==
X-Received: by 2002:a05:6e02:17c9:b0:405:5e08:a3e4 with SMTP id e9e14a558f8ab-42481911882mr110200895ab.1.1758400737038;
        Sat, 20 Sep 2025 13:38:57 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4244afaa351sm39931395ab.29.2025.09.20.13.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:38:56 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/18] iommu/riscv: Use data structure instead of individual values
Date: Sat, 20 Sep 2025 15:38:53 -0500
Message-ID: <20250920203851.2205115-23-ajones@ventanamicro.com>
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

From: Zong Li <zong.li@sifive.com>

The parameter will be increased when we need to set up more fields
in the device context. Use a data structure to wrap them up.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/riscv/iommu.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 901d02529a26..a44c67a848fa 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -988,7 +988,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
  * interim translation faults.
  */
 static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, u64 fsc, u64 ta)
+				     struct device *dev, struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
@@ -1022,10 +1022,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
 		tc = READ_ONCE(dc->tc);
-		tc |= ta & RISCV_IOMMU_DC_TC_V;
+		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
 
-		WRITE_ONCE(dc->fsc, fsc);
-		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->fsc, new_dc->fsc);
+		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1304,20 +1304,20 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
-	u64 fsc, ta;
+	struct riscv_iommu_dc dc = {0};
 
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
 
-	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
-	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
-	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
-	     RISCV_IOMMU_PC_TA_V;
+	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+		 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
+			   RISCV_IOMMU_PC_TA_V;
 
 	if (riscv_iommu_bond_link(domain, dev))
 		return -ENOMEM;
 
-	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 
@@ -1408,9 +1408,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc dc = {0};
+
+	dc.fsc = RISCV_IOMMU_FSC_BARE;
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
@@ -1429,8 +1432,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_dc dc = {0};
+
+	dc.fsc = RISCV_IOMMU_FSC_BARE;
+	dc.ta = RISCV_IOMMU_PC_TA_V;
 
-	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 
-- 
2.49.0


