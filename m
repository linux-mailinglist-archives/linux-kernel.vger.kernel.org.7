Return-Path: <linux-kernel+bounces-762764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE57B20AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E133BE494
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12301DF99C;
	Mon, 11 Aug 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkFdkxxv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C21E3DFE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920210; cv=none; b=u+e2BbuifQ8lbv/QdsBLT/HmU0jx4ZnKIXqLHPKXp1p1G06XPQILx9AIZjnyku0Bg6lXu2D2uVCTRf/ew7pS3P6jJKb05kXvquUTIUol/C1HIWj7VrlO5Ui0/umUjFQLgxD8bnCUz4ecsUTirq3w8AP5zvtrx1tgQpeOcUC+DtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920210; c=relaxed/simple;
	bh=XnHbj9QBkLJy0W+qbz9eTgXoyKBZkhMdcwnehpypp8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccDNzXMBM7/K9GO7KSgOcOQsdMCxZ2xOBHvVFaHNigVECmyejF6QiZxTzT6q28UVxe832SInFSvGLNvbX/NSSyn84Wtq4KKa+fgmLv+CTSQaSRZUKRvwIInIZBeKuLYqFBPiOA4/pvTKW1KEUHnfIytqutTYk+/d0AUxyHZFr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkFdkxxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2091CC4CEF7;
	Mon, 11 Aug 2025 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754920209;
	bh=XnHbj9QBkLJy0W+qbz9eTgXoyKBZkhMdcwnehpypp8g=;
	h=From:To:Cc:Subject:Date:From;
	b=NkFdkxxvdgOvS9b8k6rkmHTgLWsUR6rhRZkv//2qpd4fqlfLJpgfwk2YGLGm8pnmt
	 219WXyHQo8E5Nz0d+pXsffv42ZJR4eOujdM2zrfJgjbKHP6DAYLSsPM45F+XpR4BK8
	 HmMRuAVbxZnHxMBi1m0prYB7fXWaofvgwVHhyDxMK4PAKwFGylClNHolhrTywOc4SB
	 m1d6Jxj1+Bx9J58T+fR2lQ0Iu14TCEDho5ZAHw0YrLmDjDErIx3OGT1p/VIbCdeTWg
	 OfZ9YfK05uAHlqsYW4eP7wZsjb5z7AohAFUX3ZbctH60y5CE7MlpKNKCr+dSSM0sWI
	 hkKOqCzxX8v7Q==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/gic-v5: Fix kmemleak L2 IST table entries false positives
Date: Mon, 11 Aug 2025 15:50:01 +0200
Message-ID: <20250811135001.1333684-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

L2 IST table entries are allocated with the kmalloc interface
and their physical addresses are programmed in the GIC (either
IST base address register or L1 IST table entries) but their
virtual addresses are not stored in any kernel data structure
because they are not needed at runtime - the L2 IST table entries
are managed through system instructions but never dereferenced
directly by the driver.

This triggers kmemleak false positive reports:

unreferenced object 0xffff00080039a000 (size 4096):
  comm "swapper/0", pid 0, jiffies 4294892296
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    kmemleak_alloc+0x34/0x40
    __kmalloc_noprof+0x320/0x464
    gicv5_irs_iste_alloc+0x1a4/0x484
    gicv5_irq_lpi_domain_alloc+0xe4/0x194
    irq_domain_alloc_irqs_parent+0x78/0xd8
    gicv5_irq_ipi_domain_alloc+0x180/0x238
    irq_domain_alloc_irqs_locked+0x238/0x7d4
    __irq_domain_alloc_irqs+0x88/0x114
    gicv5_of_init+0x284/0x37c
    of_irq_init+0x3b8/0xb18
    irqchip_init+0x18/0x40
    init_IRQ+0x104/0x164
    start_kernel+0x1a4/0x3d4
    __primary_switched+0x8c/0x94

Instruct kmemleak to ignore L2 IST table memory allocation
virtual addresses to prevent these false positive reports.

Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Closes: https://lore.kernel.org/lkml/cc611dda-d1e4-4793-9bb2-0eaa47277584@huawei.com/
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-irs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index ad1435a858a4..e8a576f66366 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -5,6 +5,7 @@
 
 #define pr_fmt(fmt)	"GICv5 IRS: " fmt
 
+#include <linux/kmemleak.h>
 #include <linux/log2.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -117,6 +118,7 @@ static int __init gicv5_irs_init_ist_linear(struct gicv5_irs_chip_data *irs_data
 		kfree(ist);
 		return ret;
 	}
+	kmemleak_ignore(ist);
 
 	return 0;
 }
@@ -232,6 +234,7 @@ int gicv5_irs_iste_alloc(const u32 lpi)
 		kfree(l2ist);
 		return ret;
 	}
+	kmemleak_ignore(l2ist);
 
 	/*
 	 * Make sure we invalidate the cache line pulled before the IRS
-- 
2.48.0


