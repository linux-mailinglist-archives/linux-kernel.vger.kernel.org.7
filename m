Return-Path: <linux-kernel+bounces-855230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3457BE0903
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C712540673
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCCD30DEA4;
	Wed, 15 Oct 2025 19:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gZ5i6yi7"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92F308F0E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558239; cv=none; b=t0d/iKnkdgkeoAmb7V8HBayuqkGC2TlIR9eMPm7JO5NEjLJ3lla4SnMdFpEmI1PO0b3FyAS8zJmhWZAY7MrXmQ5hqGx6qSy/eK0V0p4aULbYeY2YobD/PqKDD2WEHmurYtJQ34twhr87Te7boJoffwtKaNWuWPL01GfKuGdGEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558239; c=relaxed/simple;
	bh=OtY2VdHR/b8VDb3iySDv/ds6N3IRVMqPPn4yU4l9FG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP8EV+d4xcm/Ccw8ZaNsYoBcikBFTj2FF6W2UsfHB1qqxykw/ndURr180Bq1otfHcyW/chxCimA1jLKpyEqr6w+0zlxYIdoJpHLxviGNX4iBT5OqdVY6uR9MaBcCIbzij+eUTyqdYQ2EmQMGiMcNtwfP9S8jm2m/AYot/ppIyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gZ5i6yi7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7811fa91774so20276b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760558237; x=1761163037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1cXGjl5LALpTkEmKF1wH+9n+RdSexytoXIs7SXyiuk=;
        b=gZ5i6yi7Xsy13XtgqnJ3Q9oslkvyOOqNi8HD3VoUsEO1cpeMNYhGbKMnPXe5qvnz5Z
         6GCxQI3hXQbBtpD2t4+cokCiA/QMCbnuZW2ZJzhIg9+byM4Vr1fwOuXqSDKXVsd4HwX1
         Yja6H5djrj4e8CUpO8BeJcUR1iLNerqs13zBLW4rvzV41+vKPnHkMIoaPoad74EKRaNx
         x/5vyjPsblGxuZw3nmM1/i6gbusEN6XHTAXUph58Vgfn08FwLv2we1g/jyuf/5a8mHBA
         pvkDsrcunxFUYpqBBHZ1VPr5bg914dlI34ZuwPkIjcY3EtFsvmPf+jczwsmW1nryk0Kd
         JeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760558237; x=1761163037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1cXGjl5LALpTkEmKF1wH+9n+RdSexytoXIs7SXyiuk=;
        b=dHIgEBVSKKtDBsLrSOeWGiPdZpYHJusWY26ezBOSVJwY52I5Ty3+NcUBexaOlwTv8n
         kzFRnRyLz7WLMw/jkVz51nWyt+Kyzvv68KlZFFSyBNe6umQqjRSYBQNQ8ZThcuBqqoxl
         DyZkQfvOTrdlT+UGDwVyJ8rqCyz1LTK4NQe928ieoSbpgdfVZlrKjkr29SJBw6XQNvEF
         osJGYTkaImdYLkWH3I0KzL249Cn4EdnfsUKv8wWOexUbOJJ+n3hnC0L7ZtAnqgqsatnq
         bstwHIBUYNCrXKsQrJkAN9bH0oooEr656mgZoB3zyUEY4ucN3FcFvptppuZU8Wd9oKeq
         /m8g==
X-Forwarded-Encrypted: i=1; AJvYcCWMo5A2ZF9tAciZxDYL376OHrgCv+6XK7htyoZE+awoTwK8M8cgol/bcqUNIdr9zTE+crpJ4AHrzs71YM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtao8sw3kakbmcNKeqdc3ePnGr29fl9iW9vELdPEXkPgiu8d4
	fgbrhlM+Jg6Ya6XkN4pWQ6uL2QNwTmjxX7pf0/wJFkMfMi6adhAZ3c3LJNgSdORDMDE=
X-Gm-Gg: ASbGnctCGVUvoXlsrntuyPQQ7sr5BnGQrh2AUVv+BlS/GdsKJla6Q0hx/EbWY6KN//1
	4FVY+HN5R44pygu1/AFu7ZHZND7T5d3yLit9h/Z56ELLub0pJKahgPJcQ33ogAOFnHIqd9vgnZP
	Y/bclVeaxRGh40ZkXxMbR5WIyT92ZJZzGrN9bPyzc6Xk3z1KjFqJrQk95CcYGiT4Im7skUbK71L
	fC9Cow7uxBgDOnQOmBqOXQOd3HQpgEREbQvqIkqFUQpSRXG1YHyQbQjUAXz6fgxcIXJWtzOK6mw
	v+NAGd2khMe0u1TYY/1jFfGqwzOI3X+7SClOLrUKH7eB5h5Gw5zliYSBJJUTdEW8Kd3sR9HIqae
	1SIiDsw67W9AQvMdnu/AqylMTxHf6tGVqdJ28VwXdQCLyFP64QuX3qDnDI9zz672L5vdOc8rX5g
	==
X-Google-Smtp-Source: AGHT+IFLZrPjORuUwaeRdJWDWHubXFyOAKctiPm3J2eMbE7qpSS37pMYp1CngUyq68x7ODSrNq0gxQ==
X-Received: by 2002:a05:6a21:9993:b0:2e4:9004:530c with SMTP id adf61e73a8af0-32da8206d98mr40544884637.17.1760558237119;
        Wed, 15 Oct 2025 12:57:17 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b06075fsm20151322b3a.17.2025.10.15.12.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:57:16 -0700 (PDT)
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
Subject: [PATCH 3/4] irqchip/riscv-imsic: Inline imsic_vector_from_local_id()
Date: Wed, 15 Oct 2025 12:55:14 -0700
Message-ID: <20251015195712.3813004-4-samuel.holland@sifive.com>
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

This function is only called from one place, which is in the IRQ
handling hot path. Inline it to improve code generation and to take
advantage of this_cpu operations. lpriv and imsic->base_domain can
never be NULL because irq_set_chained_handler() is called after they
are allocated.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/irqchip/irq-riscv-imsic-early.c | 11 +++--------
 drivers/irqchip/irq-riscv-imsic-state.c | 10 ----------
 drivers/irqchip/irq-riscv-imsic-state.h |  2 --
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 2c4c682627b8..6bac67cc0b6d 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -91,9 +91,8 @@ static int __init imsic_ipi_domain_init(void) { return 0; }
  */
 static void imsic_handle_irq(struct irq_desc *desc)
 {
+	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int cpu = smp_processor_id();
-	struct imsic_vector *vec;
 	unsigned long local_id;
 
 	/*
@@ -113,16 +112,12 @@ static void imsic_handle_irq(struct irq_desc *desc)
 			continue;
 		}
 
-		if (unlikely(!imsic->base_domain))
-			continue;
-
-		vec = imsic_vector_from_local_id(cpu, local_id);
-		if (!vec) {
+		if (unlikely(local_id > imsic->global.nr_ids)) {
 			pr_warn_ratelimited("vector not found for local ID 0x%lx\n", local_id);
 			continue;
 		}
 
-		generic_handle_irq(vec->irq);
+		generic_handle_irq(lpriv->vectors[local_id].irq);
 	}
 
 	chained_irq_exit(chip, desc);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index 9a499efdebe3..385368052d5c 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -434,16 +434,6 @@ void imsic_vector_debug_show_summary(struct seq_file *m, int ind)
 }
 #endif
 
-struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id)
-{
-	struct imsic_local_priv *lpriv = per_cpu_ptr(imsic->lpriv, cpu);
-
-	if (!lpriv || imsic->global.nr_ids < local_id)
-		return NULL;
-
-	return &lpriv->vectors[local_id];
-}
-
 struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask)
 {
 	struct imsic_vector *vec = NULL;
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 196457f1bbca..6332501dcbd8 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -95,8 +95,6 @@ static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *ve
 void imsic_vector_force_move_cleanup(struct imsic_vector *vec);
 void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
 
-struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id);
-
 struct imsic_vector *imsic_vector_alloc(unsigned int irq, const struct cpumask *mask);
 void imsic_vector_free(struct imsic_vector *vector);
 
-- 
2.47.2


