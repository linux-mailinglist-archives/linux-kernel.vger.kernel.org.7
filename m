Return-Path: <linux-kernel+bounces-733529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CE1B075D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CA8507C73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1F2F4A07;
	Wed, 16 Jul 2025 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="adWC/ws6"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65782F3C35
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669478; cv=none; b=uRP99X0K14/7fvzCGszAEeBAmTgM6LC/g63CgdD1YW7HhjEtbOoKc1Pmd07CSskWCyDyMV39WGR/67PHL4OUio4MPUXfb+1d315eFFy5WrgqY/IWpyhFNRB81x0lcFP9GC3n/iUNGETEXYJW+HX+No6pr8M7Bq2n3sjIP080UbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669478; c=relaxed/simple;
	bh=5Owa48wB/dCPh/oS/jbcKVDLTJVA5hmFeOA7csZZl9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dzZrXpSi8Q+JuU3eG3stXSUZ6e2T1uzl45Fjjv7iGdfsIpVHVVHRuOE23TDRNpfAbaTIBw8Zy3kH5+bmTnY8Rl1xT6jgnhGpide0ycX71ky35TDky7DMSGt9XtFbzJatJvIDrEajLMSOWeSmxk7peAU1bMSpisqOeUwizB4ebrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=adWC/ws6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2352400344aso59131805ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1752669476; x=1753274276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mRLSENgI/MGJbaGVqAa8IBYA8T+PU3c6shTbsSeztZI=;
        b=adWC/ws6Dh9ng30zukjp8eaE6NXkpJHeNZr4w+O0VQcuz/p0eD2X8KXkf+SV4+Z2/n
         3Z97rJKt2o9amggd9LQzJ1T4jGv7nE4G+9FbzN4jhWXSRfwSC7prsnBGRTdtavZgWh/E
         mj6p8FgVnr2pigBU/o/0yQHqvfuKeG+emRXLTCz2COxPukNW199dwU8cAonR30zPuI57
         Q/4Y69l8rap6zi00gGYGCARXdiYj/dJK+1uy9ccKLbFkwO0F/WybTKiZW/d+bEC3HPLf
         7KNQy9KeLEFwp6GsJVEGqXCSMFCxKGMaofUVatAAuxjaghGdLWVYBQ/5otk2O0ZcVDOW
         9JEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669476; x=1753274276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRLSENgI/MGJbaGVqAa8IBYA8T+PU3c6shTbsSeztZI=;
        b=NVpFFhLvDe5fHr2KhgGzCfEuxAaaSF5lECcOkALe3d998TsdERyTlXuxF1kmDIFTxG
         gaAAIImoPuO19yXX36VmKP2KHzU77cakrH3YTaJPVA+p8Two+CzbiCUxuDU9GD9wlcUc
         bl64lZbzXnf+0+FZXxluROppTSH/nUCr6XaYvCWdjqtd2ofGye0OHKXTl18bxWqhDSaB
         do6Dz4KoDVOAFwvb89jCWDDIleZ3tyBWNodtegMH/o6mE7lpbQ5sHnXms1NHK3K03YD4
         gnur8Tpf0t5OOYEX+EgkmlpSCOFKoQhpt70j7Xk/Nrsuo5lj3vWRfDtIXeTCnm/f9BF4
         R17A==
X-Forwarded-Encrypted: i=1; AJvYcCXvWSbJQzxcc3CqhS2t7KsReC/XPJwpLwGjHLiJu2bN8xXT1HzdfUj8E/6rZgvaTVrshrdfGkaDUZoLA4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+afMz7fgmwpFEH1jPLQKGXE076hxgEtAr9Md/zfreY5bU2mIK
	ebZbDiPfxpLEOTyEHE0haqvtHJfeC74naSERD027wfvS8+0cEbsfOnIf7f3T3/U7lCE=
X-Gm-Gg: ASbGncslQ105VY/4TsjB3mEohevA8gKK4d5f5OdxqRHIDHNtr06S1Mn8xMbRKO3PGYH
	3utvVLalHEr9n0gAmC1wVEL2CqY8KfJrNgeT3HJo9cU6/76LO40gCcEz4211fNZbYBSmtJL0u39
	T/NyqfXbXjZcweaLiI5UMZfjmUpFwRyTbfRq/I12QyYQ0a7409jQbXVdtgRNtWjlVm/Bov0wYKg
	Q/evqgFKGnY+IjWk6yBAH5zcnRkIGUn1N7GbQiORU7krvYg+2vx2w11kXvztgTV2nW0/RCpeHqd
	DtjFuhER+jgMpKC16KCg6H9uUz+zh53ut4cJRljEKaXBU3n2Q2M0MWDd+Freu2ifEX4c0gm68X1
	d1dixKIU3gJ4DBOnz+mbznzOciN6EqwejgSEfq+3O+8ZqNKySj06wQg==
X-Google-Smtp-Source: AGHT+IFS0ERKXZDU/2paRwDAwj1qIE00GcJ4rlO9U8G8qiuVi07BwHIJVfO1FD2FE0d9SCuPJE4CnA==
X-Received: by 2002:a17:902:ecd1:b0:22c:3609:97ed with SMTP id d9443c01a7336-23e24fbf7bcmr36821175ad.30.1752669475780;
        Wed, 16 Jul 2025 05:37:55 -0700 (PDT)
Received: from localhost.localdomain ([122.171.23.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e2b31aba5sm5148085ad.0.2025.07.16.05.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:37:54 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4] irqchip/riscv-imsic: Add kernel parameter to disable IPIs
Date: Wed, 16 Jul 2025 18:07:45 +0530
Message-ID: <20250716123745.557585-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When injecting IPIs to a set of harts, the IMSIC IPI support will do
a separate MMIO write to the SETIPNUM_LE register of each target hart.
This means on a platform where IMSIC is trap-n-emulated, there will be
N MMIO traps when injecting IPI to N target harts hence IMSIC IPIs will
be slow on such platform compared to the SBI IPI extension.

Unfortunately, there is no DT, ACPI, or any other way of discovering
whether the underlying IMSIC is trap-n-emulated. Using MMIO write to
the SETIPNUM_LE register for injecting IPI is purely a software choice
in the IMSIC driver hence add a kernel parameter to allow users disable
IMSIC IPIs on platforms with trap-n-emulated IMSIC.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
Changes since v3:
 - Rebase upon Linux-6.16-rc4
 - Make imsic_noipi as __ro_after_init
Changes since v2:
 - Skip enabling/disabling IMSIC_IPI_ID in imsic_ipi_starting_cpu()
   and imsic_ipi_dying_cpu() when imsic_noipi is set
 - Re-use the reserved IPI ID for devices when imsic_noipi is set
Changes since v1:
 - Added more details to patch description
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 drivers/irqchip/irq-riscv-imsic-early.c       | 20 ++++++++++++++++++-
 drivers/irqchip/irq-riscv-imsic-state.c       |  7 ++++---
 drivers/irqchip/irq-riscv-imsic-state.h       |  1 +
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..7f0e12d0d260 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2538,6 +2538,13 @@
 			requires the kernel to be built with
 			CONFIG_ARM64_PSEUDO_NMI.
 
+	irqchip.riscv_imsic_noipi
+			[RISC-V,EARLY]
+			Force the kernel to not use IMSIC software injected MSIs
+			as IPIs. Intended for system where IMSIC is trap-n-emulated,
+			and thus want to reduce MMIO traps when triggering IPIs
+			to multiple harts.
+
 	irqfixup	[HW]
 			When an interrupt is not handled search all handlers
 			for it. Intended to get systems with badly broken
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index d9ae87808651..2709cacf4855 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -8,6 +8,7 @@
 #include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
+#include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -21,6 +22,14 @@
 #include "irq-riscv-imsic-state.h"
 
 static int imsic_parent_irq;
+bool imsic_noipi __ro_after_init;
+
+static int __init imsic_noipi_cfg(char *buf)
+{
+	imsic_noipi = true;
+	return 0;
+}
+early_param("irqchip.riscv_imsic_noipi", imsic_noipi_cfg);
 
 #ifdef CONFIG_SMP
 static void imsic_ipi_send(unsigned int cpu)
@@ -32,12 +41,18 @@ static void imsic_ipi_send(unsigned int cpu)
 
 static void imsic_ipi_starting_cpu(void)
 {
+	if (imsic_noipi)
+		return;
+
 	/* Enable IPIs for current CPU. */
 	__imsic_id_set_enable(IMSIC_IPI_ID);
 }
 
 static void imsic_ipi_dying_cpu(void)
 {
+	if (imsic_noipi)
+		return;
+
 	/* Disable IPIs for current CPU. */
 	__imsic_id_clear_enable(IMSIC_IPI_ID);
 }
@@ -46,6 +61,9 @@ static int __init imsic_ipi_domain_init(void)
 {
 	int virq;
 
+	if (imsic_noipi)
+		return 0;
+
 	/* Create IMSIC IPI multiplexing */
 	virq = ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
 	if (virq <= 0)
@@ -88,7 +106,7 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	while ((local_id = csr_swap(CSR_TOPEI, 0))) {
 		local_id >>= TOPEI_ID_SHIFT;
 
-		if (local_id == IMSIC_IPI_ID) {
+		if (!imsic_noipi && local_id == IMSIC_IPI_ID) {
 			if (IS_ENABLED(CONFIG_SMP))
 				ipi_mux_process();
 			continue;
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 77670dd645ac..dc95ad856d80 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -134,7 +134,7 @@ static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 	lockdep_assert_held(&lpriv->lock);
 
 	for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1) {
-		if (!i || i == IMSIC_IPI_ID)
+		if (!i || (!imsic_noipi && i == IMSIC_IPI_ID))
 			goto skip;
 		vec = &lpriv->vectors[i];
 
@@ -419,7 +419,7 @@ void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, int i
 	seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
 	seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_id);
 	seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
-		   (vec->local_id <= IMSIC_IPI_ID) ? 1 : 0);
+		   (!imsic_noipi && vec->local_id <= IMSIC_IPI_ID) ? 1 : 0);
 	seq_printf(m, "%*sis_enabled      : %5u\n", ind, "", is_enabled ? 1 : 0);
 	seq_printf(m, "%*sis_move_pending : %5u\n", ind, "", mvec ? 1 : 0);
 	if (mvec) {
@@ -583,7 +583,8 @@ static int __init imsic_matrix_init(void)
 	irq_matrix_assign_system(imsic->matrix, 0, false);
 
 	/* Reserve IPI ID because it is special and used internally */
-	irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
+	if (!imsic_noipi)
+		irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 3202ffa4e849..57f951952b0c 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -61,6 +61,7 @@ struct imsic_priv {
 	struct irq_domain			*base_domain;
 };
 
+extern bool imsic_noipi;
 extern struct imsic_priv *imsic;
 
 void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend, bool val);
-- 
2.43.0


