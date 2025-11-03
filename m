Return-Path: <linux-kernel+bounces-883320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C55C2D0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0A3E4E5C0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E143161A4;
	Mon,  3 Nov 2025 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsWVovaK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA9316185
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186720; cv=none; b=Kx6G+oxPyBV1zAvd084f0qVz6Ksfp7luUoDwHv/+jX/FJ1ifllR6/eqafP6haRxmWkhd+rby2+qhwrwR78QFyl+5g4Be+22H5l2hzNsZBW7ObXsZdcPgzTNeBmCrY8KU3bwRq2fCViK6qlTm/InTAZqm1te/edn7uEAXhtCn9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186720; c=relaxed/simple;
	bh=9IL4uEHSH1TQDJe2aI3li5/cp3GxB4EPdYuPtkpRhpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCVVYRu121oEvifztyPkvRDtDTegljjviAjAA5841N5Mt/y+XktcmfsUWDSwlJCBI0knUz1+Qo4U/NVpIcciJm7KnxxWNEaXtk9k1fRdFpGZJtUKj37kubvxeiZ0w8Jrs/hsZfXm+XHVubOYvspAQXdsNH5udwPie6EEw2ynRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsWVovaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762186716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ezCNaUCKcpwGk7sWAga5EHhyDCPk/Oxt4aXzp6O1YvQ=;
	b=MsWVovaKdxvefRcf+wwIbtRXwwUvS6AW9xkxCbYukXnCYVF6VXJQG+PZzhyNGC7m8HKlvL
	fgYD3aP+/OiMo/Q4LAIAja5jQ1duBd5pDD10sIzwdCsZFl7e0ItbfCH3HZT111kzL6dzlW
	1wgkU5cYqPcWpgdKfCqldpzwBPy9XJM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-5ogMiM_RPI6yIOzf3m55fA-1; Mon,
 03 Nov 2025 11:18:33 -0500
X-MC-Unique: 5ogMiM_RPI6yIOzf3m55fA-1
X-Mimecast-MFC-AGG-ID: 5ogMiM_RPI6yIOzf3m55fA_1762186710
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 838B81800669;
	Mon,  3 Nov 2025 16:18:29 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.64.253])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3EDAD30001A1;
	Mon,  3 Nov 2025 16:18:27 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
	linux-riscv@lists.infradead.org,
	Lucas Zampieri <lzampier@redhat.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <pjw@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] irqchip/sifive-plic: fix call to __plic_toggle in M-Mode code path
Date: Mon,  3 Nov 2025 11:18:13 -0500
Message-ID: <20251103161813.2437427-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The code path for M-Mode linux that disables interrupts for other contexts
was missed when refactoring __plic_toggle.

Since the new version caches updates to the state for the primary context,
its use in this codepath is no longer desireable even if it could be made
correct.

Replace the calls to __plic_toggle with a loop that simply disables all of
the interrupts in groups of 32 with a direct mmio write.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510271316.AQM7gCCy-lkp@intel.com/
Fixes: 14ff9e54dd14 ("irqchip/sifive-plic: Cache the interrupt enable state")

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cbd7697bc148..0de3003981f1 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -592,12 +592,12 @@ static int plic_probe(struct fwnode_handle *fwnode)
 		if (parent_hwirq != RV_IRQ_EXT) {
 			/* Disable S-mode enable bits if running in M-mode. */
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
-				void __iomem *enable_base = priv->regs +
+				u32 __iomem *enable_base = priv->regs +
 					CONTEXT_ENABLE_BASE +
 					i * CONTEXT_ENABLE_SIZE;
 
-				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
-					__plic_toggle(enable_base, hwirq, 0);
+				for (int j = 0; j <= nr_irqs / 32; j++)
+					writel(0, enable_base + j);
 			}
 			continue;
 		}
-- 
2.43.0


