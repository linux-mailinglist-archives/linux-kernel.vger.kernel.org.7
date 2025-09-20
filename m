Return-Path: <linux-kernel+bounces-825897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 472E3B8D107
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 152F84E0494
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DC2E0926;
	Sat, 20 Sep 2025 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="oAnTD/14"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424882DE711
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400747; cv=none; b=OLyLrxJBREVYsuP5gyqzOZM9/GOIVbWbOfZF77xLh2n4UnBso9FpGibtaruDCLC5DBfZsvR+i3lDeuIpqSWfxkTC4FSLAylU42YbZqk9/tFzyp28/ollYZaHpoCu4bIvIivyQiw3V6q4FiAHsOGrjiOvrpD+HDkUnGmVgcLrGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400747; c=relaxed/simple;
	bh=FfOMQJOET+fXIoGZ1uM25aIVQjCYOD9kzF8+9pRr/5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUHCGT6//UFTufApLsNOkQ/YI+83/nGLOL85lBpW5IXihjubm3iNoc82sje2WlYVYiEll+mIlF1I+d0CH+hV61UhGAImU9SM4DqeYdsCnC+PhrFEHeXea2fY+m74/xOP+c9J2jURg82tL7UK5FMbkV5YSLbaC55ZPhsjmyP6m1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=oAnTD/14; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88cdb27571eso111426439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758400744; x=1759005544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyclL1XhlEcYsrqgE10jIhLpC+mtwJUT0A78Decqu/E=;
        b=oAnTD/14RXpyUYUTE7DUHZ5AdYeVu2JrtCEIkYIrfYFlR4hdUIYAbO0CkR3l5UjDSm
         PRyJBiibZqynglRci4k1L+fa+Jvt1LFeogcdzy16Hg9M+HsXgHJ6pAmYF7oJA2SRMfcn
         21zbKBrLKcpeL+zGmErWt37uKtijqPn0WQWS1hGrpZK/OIpQKiOgnEfVdaQl1nyUA6c6
         KDRFcNgyxf5NQS3Vbw+blK20orkLJN008l1fygbDZQUeA897t4NejaBMXqCUP/oP9zCh
         SR83dLgFUXX07xvNOTluyydCj3pfWW4cwSLXzNFCnuUvib2NJ/o+dvbq9iWLN0AS1r/d
         snGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758400744; x=1759005544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyclL1XhlEcYsrqgE10jIhLpC+mtwJUT0A78Decqu/E=;
        b=Srk28hgUcL/Y5SgtiS6zqi1oh4dcdc1dDyzV5v+OqNkH2ruEr0rl3sLdGxy9gdheeM
         2DFJrWhZuesrvOScRCEB6R34/ViabcbNgUHzQ9nYGaFkH+Kzqg+y91hTLAithaT3c9IL
         hQy/saKDW3/rovjOwlBEA4qpDEk+pNJOzkcUyPY+rCsOE6UxPg5kB9cBYbWi3H+xHnsn
         zQU6AWy+7R1vLDwVRBaGs8FOtcJz2ENifvGEiC/4qkAJ0rxWg1WJ/HuEIR3zC0K40W1h
         vtTIhD5KKrQGbBqIJXhNQ9G5w4gkU2moqHS2/knnELJFKcsKRhOqP+D7mAEyLiMxeBYY
         SkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrUcNKPqUELiFy98D2Ysc6Fe4xgj79Yan7uWrCJbyrMrfP3Tw2rZUFBbQw2aDkH1f8cfZRkmIKJQYE2dA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiBT//k0Wo8tkiD7J8cu0eVeyo2oMiWlHCC0NQkn/uUNiQ/S4
	sH9Un3l1eXHMnsC+lCuTAEbI2Gla1yPGgFS2yESQ05xs2QILxJiCtS3JUkZ8eRFwxxA=
X-Gm-Gg: ASbGncvLZCnw5Sb+T3wY35j0sYaPWuU9uEB6nTg2CLERHIYlVim+DA9IjleHsQHh9DV
	tmnSIQqQcdytjMTgjvVdhLNRocsnZDa1nKk/MUAZ/ABNALZR28wb9CCgLBwyl0LU+iKn/yEZv3W
	hEGUmLIwSOLkBzavBdvc6VyPEvIug5fO9btROFQZCqqRLpAUZVY9mPEdQFuXO7B8IWlq1msD9AR
	nWhhl9Gyp7FyC0UknPi3Ac0NR8k3IqOTSsLovwVLn8Dsf1DKMS0Xid2AeT37jrM7O5m41dvwG06
	P/WZ6hVtql10sJ1K0IHCxO+6dTeWlhzR4nFNH35LA3GXgslqyh7j6qnC2AmIugpBKzXf4A7r6il
	qksmCUiBczjVAoAAB414BULgl
X-Google-Smtp-Source: AGHT+IG40gGHsXsi5eSQylQi3Zsm0ULLvlAN1CN/2lldqNCL8Ji0Ye7gijLwVVX5LjTNRaDqmRWawQ==
X-Received: by 2002:a05:6602:6d04:b0:887:788c:d345 with SMTP id ca18e2360f4ac-8addc8a1170mr1309874539f.12.1758400744491;
        Sat, 20 Sep 2025 13:39:04 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a46b2f3405sm304724039f.1.2025.09.20.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 13:39:04 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/18] iommu/dma: enable IOMMU_DMA for RISC-V
Date: Sat, 20 Sep 2025 15:38:59 -0500
Message-ID: <20250920203851.2205115-29-ajones@ventanamicro.com>
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

From: Tomasz Jeznach <tjeznach@rivosinc.com>

With iommu/riscv driver available we can enable IOMMU_DMA support
for RISC-V architecture.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..9d8c90690275 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -150,7 +150,7 @@ config OF_IOMMU
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-	def_bool ARM64 || X86 || S390
+	def_bool ARM64 || X86 || S390 || RISCV
 	select DMA_OPS_HELPERS
 	select IOMMU_API
 	select IOMMU_IOVA
-- 
2.49.0


