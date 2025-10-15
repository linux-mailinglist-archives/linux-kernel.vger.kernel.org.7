Return-Path: <linux-kernel+bounces-855231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C19BE0906
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2705E427DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8288305E1D;
	Wed, 15 Oct 2025 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eS/iiid/"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC8F30C36E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558241; cv=none; b=nRhQ3g5ECunuHM+W9RRzd2WPwOVqgBMtTJSkNPwTb+FEnRXlkTd3BhSfZDuWStW3zloEg9gsaahr32bPLToeLTgYUTlYz+4t6/0AlFYNm9OwkEmpdrDnVaaDOr2wBb/gzUj0YMNJn8bjyMEFqAh0dbfG3JN/8dbD5ZhNbimvQJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558241; c=relaxed/simple;
	bh=Nkic0FtET94irIFY4HGDaRKQwLjCuCRJNbjooCsCJ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWZVurfb3zAyROQzZ1GvKGPtcSZP5mgNols7YsNjg5qSCOMmq+dpLV1g/6FLQphs4ucznl2Q20PmWt2vYx/5DGIajsuCBkHIhk4hYguhJHIegzDqEFWAJH0lIvUtP9FzvPBagoBzh4jHdKlyFNmzU4qsp48KercdvM7sV6WrfNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eS/iiid/; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78125ed4052so25695b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760558238; x=1761163038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+g8lhoHRY5Iwc3gNxWC8a/yM7D/uKYdnjVnSP6JGxc=;
        b=eS/iiid/STw22y1fdKhWfrllffB46nObHUTBVYA+rAzgjgli2r6aKLz4xQtc9Pw2TJ
         CHZWWCrKLgXDxQ1FsSanXdfyyj3uDHu3dzCakUyVCJB/NqG6x5m/bve2qiyA2lODqrkO
         j74OgnnWTUlRTZ/PsPxY372LMHiqyETUvNFVbpMknu4JoqHMWRPqT0irGYExmTaPLwj5
         6FpOXU4QaxfYYyPTmzegU5ku8iPb0Ql0+hpqSxmYPUV1PYJsq1vZOEgcNkafD5AJkJuI
         JhENakcZwdmK3XxkWZPu+3dZuz83ZeQEhsFtrlRzfJp452kPldQPKVWXSVxQxB3dYlf8
         qofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558238; x=1761163038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+g8lhoHRY5Iwc3gNxWC8a/yM7D/uKYdnjVnSP6JGxc=;
        b=I374DoLKsIrFAXt7QwYAQhfodCNUkY00PVbX55PbtPD4T+tWqUcLTrskIGrdnyeH0k
         AclOorQF412o2GPl0Xkx1pG7ibcPJarih6AI+1WKGk0oSdvkd3A4Dx7kweBsjfE+ujva
         fHFhvnxhohtW16gajc97fdsXjb4HPme7QFhlY251TmFw9IDgi2JdbEX0NM1zqEhvHGK5
         bEvavra466Vba8Xh7A04du54FzSBd/RmzZJLzjqDnH1Cjikh01KGnAAZZqaAHC3aQxQq
         mvCcsnOTZY6zfM4Tw8PQ90xiria/yTh8tHH2xKAMVA2oPafIKCK2FeOFkskVu4NeGsf4
         1EzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeH7Ji1/BeCemvVeG75MgtMlK/DoUPvCp8NXJ9oQb0iFI++FGZQ4wLtNBdE1B7qojgQjS0ZVgK/8s9BDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADJDAybPPOEoXGsApcq4E+py5po8Eoc2MvBY4UJ04/skjS8bJ
	aNV1RPESUmM6jiaA8CJtDj4DkgPJBRDE74g+6Ae0WPtIQTDxuZq2PR6oLECxeq2/d0M=
X-Gm-Gg: ASbGncsIew55Wuez/HPFhRqL5L6HMSeOs1BUxhDFU8K9uREOo6+3EkiKhdIlXjV6dfR
	3sXrKsCF4K121mtpBw6j41duhwVfb40e6uP+xhikb/33LFfy5ehJ0ZR2nvRb22qt2qAe6KsMUXl
	+XulEZOy0gU8IHbKFf/R0Yq0zNG/qpLNKlEElb17yQuq6W+FltFzk3oj3GDoSZ0JKBCBxSxin3U
	C8X+ueALGL+jj623q8boTOiORZIG5CDVXZZRybYXXHxE62jbvic3afNOmg8ect1bsSxVKrg1xNR
	eSdVwEdiuiF/BrELr8QXkJAfND93vO3fjCNffD/Tfzw7I1uFX05yl8xgJD3kX8UvnqySmusrjCk
	k9tyagpoPyOX6KsnbX0TCXBQllIpldcLoatA2K3OpJvSP+JHQauxr3q12/ENha8CkIpVDnXYv6l
	v50TShDUZMRb0Uc18ekbtGPw==
X-Google-Smtp-Source: AGHT+IEKQ+uDEI7W9I1l+VaCyNVgX9OC+Z12nOqaxOeClud0KyIU0We9Y4LSjxHB28Nwak6ZUg9h4Q==
X-Received: by 2002:a05:6a00:2e13:b0:781:1771:c12c with SMTP id d2e1a72fcca58-7938269d8b7mr37200981b3a.0.1760558238577;
        Wed, 15 Oct 2025 12:57:18 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b06075fsm20151322b3a.17.2025.10.15.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:57:17 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 4/4] irqchip/riscv-imsic: Remove irq_desc lookup from hot path
Date: Wed, 15 Oct 2025 12:55:15 -0700
Message-ID: <20251015195712.3813004-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251015195712.3813004-1-samuel.holland@sifive.com>
References: <20251015195712.3813004-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IMSIC driver uses the IRQ matrix allocator, so there is an arbitrary
mapping from the per-CPU interrupt identity to the global irq number. As
a result, the driver maintains a table of vectors so it can look up the
virq number during interrupt handling. The driver uses the virq for one
main purpose: it gets passed to generic_handle_irq(), which then uses it
to look up the irq_desc in the sparse_irqs tree.

Taking inspiration from the loongarch AVEC irqchip driver, skip the tree
lookup by storing a pointer to the irq_desc in the vector table and
calling generic_handle_irq_desc() directly.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-riscv-imsic-early.c    |  2 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |  7 ++++---
 drivers/irqchip/irq-riscv-imsic-state.c    | 10 +++++-----
 drivers/irqchip/irq-riscv-imsic-state.h    |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 6bac67cc0b6d..f3afcfa3242d 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -117,7 +117,7 @@ static void imsic_handle_irq(struct irq_desc *desc)
 			continue;
 		}
 
-		generic_handle_irq(lpriv->vectors[local_id].irq);
+		generic_handle_irq_desc(lpriv->vectors[local_id].desc);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 7228a33f6c37..89618d2791c2 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -131,7 +131,7 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 		return -EBUSY;
 
 	/* Get a new vector on the desired set of CPUs */
-	new_vec = imsic_vector_alloc(old_vec->irq, mask_val);
+	new_vec = imsic_vector_alloc(old_vec->desc, mask_val);
 	if (!new_vec)
 		return -ENOSPC;
 
@@ -225,13 +225,14 @@ static struct irq_chip imsic_irq_base_chip = {
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				  unsigned int nr_irqs, void *args)
 {
+	struct irq_data *data = irq_get_irq_data(virq);
 	struct imsic_vector *vec;
 
 	/* Multi-MSI is not supported yet. */
 	if (nr_irqs > 1)
 		return -EOPNOTSUPP;
 
-	vec = imsic_vector_alloc(virq, cpu_online_mask);
+	vec = imsic_vector_alloc(irq_data_to_desc(data), cpu_online_mask);
 	if (!vec)
 		return -ENOSPC;
 
@@ -239,7 +240,7 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			    handle_edge_irq, NULL, NULL);
 	irq_set_noprobe(virq);
 	irq_set_affinity(virq, cpu_online_mask);
-	irq_data_update_effective_affinity(irq_get_irq_data(virq), cpumask_of(vec->cpu));
+	irq_data_update_effective_affinity(data, cpumask_of(vec->cpu));
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 385368052d5c..f37800da3746 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -179,7 +179,8 @@ static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 			tvec = vec->local_id == mvec->local_id ?
 				NULL : &lpriv->vectors[mvec->local_id];
 
-			if (tvec && !irq_can_move_in_process_context(irq_get_irq_data(vec->irq)) &&
+			if (tvec &&
+			    !irq_can_move_in_process_context(irq_desc_get_irq_data(vec->desc)) &&
 			    __imsic_id_read_clear_pending(tvec->local_id)) {
 				/* Retrigger temporary vector if it was already in-use */
 				if (READ_ONCE(tvec->enable)) {
@@ -434,7 +435,7 @@ void imsic_vector_debug_show_summary(struct seq_file *m, int ind)
 }
 #endif
 
-struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask)
+struct imsic_vector *imsic_vector_alloc(struct irq_desc *desc, const struct cpumask *mask)
 {
 	struct imsic_vector *vec = NULL;
 	struct imsic_local_priv *lpriv;
@@ -450,7 +451,7 @@ struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *
 
 	lpriv = per_cpu_ptr(imsic->lpriv, cpu);
 	vec = &lpriv->vectors[local_id];
-	vec->irq = irq;
+	vec->desc = desc;
 	vec->enable = false;
 	vec->move_next = NULL;
 	vec->move_prev = NULL;
@@ -463,7 +464,7 @@ void imsic_vector_free(struct imsic_vector *vec)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
-	vec->irq = 0;
+	vec->desc = NULL;
 	irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
 	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
 }
@@ -516,7 +517,6 @@ static int __init imsic_local_init(void)
 			vec = &lpriv->vectors[i];
 			vec->cpu = cpu;
 			vec->local_id = i;
-			vec->irq = 0;
 		}
 	}
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 6332501dcbd8..a09dd140461b 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -20,7 +20,7 @@ struct imsic_vector {
 	unsigned int				cpu;
 	unsigned int				local_id;
 	/* Details saved by driver in the vector */
-	unsigned int				irq;
+	struct irq_desc				*desc;
 	/* Details accessed using local lock held */
 	bool					enable;
 	struct imsic_vector			*move_next;
@@ -95,7 +95,7 @@ static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *ve
 void imsic_vector_force_move_cleanup(struct imsic_vector *vec);
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
 
-struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask);
+struct imsic_vector *imsic_vector_alloc(struct irq_desc *desc, const struct cpumask *mask);
 void imsic_vector_free(struct imsic_vector *vector);
 
 void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, int ind);
-- 
2.47.2


