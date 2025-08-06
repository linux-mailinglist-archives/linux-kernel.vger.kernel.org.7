Return-Path: <linux-kernel+bounces-757439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E584B1C227
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B11762201F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F722248B3;
	Wed,  6 Aug 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HHoCLFf+"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564717597
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754468864; cv=none; b=dLNR06kFVsEV2XOYNuqDpQke2kKTxc4aZLtueZnOJIPPRN2dHq1eiXUVpy0ldliA05unGKN1adIPwsIEpNjwnkXqTVmHqQNqdOdF0De+RnVq2Cds8ttFd9DFumXkN5IlgDNH181czLqbY39qRATzVWlnCB93ItE5qx4g11D5G54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754468864; c=relaxed/simple;
	bh=3S3a+SX5VmO05Maec9eRE6RoCy+xO8z8HXOAJuFHZik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WSu/bwlaKtta0Rgw+UZmGaEsjar4iJy0AibxsBp7MLm06vQj2GzIFqP4PfQCbIWEmS/jL13PmySpvwzl8NILHbxYQsfSoZkA7AEShCSg00QLtZCDNStNZmIbKCA7qSviS8U/PrpljbXb+z2TiprVdNbiKufVtFu87zU4DZPHPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=HHoCLFf+; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so6107460a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1754468862; x=1755073662; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ICquv6ryhz4yGvAhRfrCL5GzjO2ttknExu9gWXkhufM=;
        b=HHoCLFf+zjep5c848W2lw0G3JOHjqP22h/v4TIZSITY+4sd9S5Ia024PU84/hyousk
         Vaa52XA6SFjgN4iz2gHKsqXtvCQgJHpW3TAhSe6RSQp1i+MrSo+uQuyxl8RS9K5eY/Ga
         OIpwnhDMijfdh9qFI607JgEnX/IUwGuHXHVAzB0Z/0x3Tj2I1S7S2RtPPQrJuQSA5Dqf
         VYmvU35wB9Kc81UO/hIbtImiwBVl+2zYNhyK4x6ZQ8pjnUK60JZjAe4l2sUuqRl0XzYJ
         0AAJLEdmsfPb5fu4ecL1++YJ4PYgJecBopO7lJ4ue8nsJ6UvOHZ0HjSF0CyHq8XCiYA4
         bx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754468862; x=1755073662;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICquv6ryhz4yGvAhRfrCL5GzjO2ttknExu9gWXkhufM=;
        b=NQT5D7bAvMGgzmgNj4FlrfUM9PJ2+FuhYJy86YdVpfGpQKVCUX/zfejVq+BBKsCcci
         gN7O8BzJfZmYpBBUuURPXbBrZ3UsMLcz4tFi1hS0knnMTw65rirHuJHjyWS5+mG81tvf
         kpzOKBjT9wlZSKV+jwBrIifHEx14mQPQqPtVYUriwAuXXEQ6YxgaaQP/qrns5OXg4RKN
         5IVOT8wDw1ZUvOURWI2D6WCmJekOTDFZDD0YYC8Ze3SLv5UXFsL3Oy1kIuj6opt2RZR6
         aGmHYpOrE/v5Qt4iZlbJ56oh/mDtb396oVI/wi8DWp3PqsTRamu2uN3T9uZExC3g/kjO
         kehw==
X-Forwarded-Encrypted: i=1; AJvYcCWqbkP795zUTZyzm6XtUYmIx3v90ZAHAJytuJXQIxWL7gjJdJJFpslmW1qaAn4zkCPng5Rz6DynJqSaEAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygb2DrW5jVOUkozxuiRuW+NAdJSpx27Go6N7slJtZQFV6ymVid
	RzCFQgBRtnpEGbcalQzVFDDny6KiQrjpgv+0dqrgXyC9hCPg9GoxnO5e3mPyONfq44Y=
X-Gm-Gg: ASbGncuySjc2fGlvIj6H0gpkQ/kYnF3dabjX1/bBhHiZZ+CihRc/MSId0LkaZhagACi
	tJPpX3iOujs6ATjzmiW1lL380MK8OYnaD/7yDhs/lQqxEhXBndLIMboYb7ptf3WGchnHr28V8vV
	0kuPjO/6IcwA2P0FM/Wlpzmt1ecpEBgxCdpK9Z4uH2c8oq4+plP4rKIgEvEtenIbe/mZ0a8nglK
	/ZH4nqBHSPQSoBI4oRxDy6mFaRI3oZtMOQZPGe7N0AV6+htGHqB2IR1ewhkNO2AGC8BoIGiqxbp
	Uqs38/m8hASRDzDkjyLu6g6b1InwdtaDt+rGK/XdTIs73bgzjPGxxhHkuUAtpmJHZ4BZIr0H4lJ
	GjowrDZhkx3ADoYVoKv2iXIGfHgCvKzdqasjdHbuqaNCB
X-Google-Smtp-Source: AGHT+IF733iTc0Ba1nKB+UFJNP5eZARUzQJ+6hiLMhjJTjgT2pG+RpgGeiBuUhrNLaGjp6P8GrowlQ==
X-Received: by 2002:a17:903:950:b0:242:9bca:863c with SMTP id d9443c01a7336-2429f583a0cmr28973785ad.54.1754468862355;
        Wed, 06 Aug 2025 01:27:42 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e897690csm151958645ad.99.2025.08.06.01.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 01:27:42 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: anup@brainfault.org,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v2 1/2] irqchip/riscv-imsic: Restore the IMSIC registers
Date: Wed,  6 Aug 2025 16:27:25 +0800
Message-Id: <20250806082726.8835-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806082726.8835-1-nick.hu@sifive.com>
References: <20250806082726.8835-1-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the system woken up from the low power state, the IMSIC might be in
the reset state. Therefore adding the CPU PM callbacks to restore the
IMSIC register when the cpu resume from the low power state.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 drivers/irqchip/irq-riscv-imsic-early.c | 40 ++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index d9ae87808651..62bcbcae8bd4 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt) "riscv-imsic: " fmt
 #include <linux/acpi.h>
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -109,14 +110,8 @@ static void imsic_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int imsic_starting_cpu(unsigned int cpu)
+static void imsic_restore(void)
 {
-	/* Mark per-CPU IMSIC state as online */
-	imsic_state_online();
-
-	/* Enable per-CPU parent interrupt */
-	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
-
 	/* Setup IPIs */
 	imsic_ipi_starting_cpu();
 
@@ -128,6 +123,19 @@ static int imsic_starting_cpu(unsigned int cpu)
 
 	/* Enable local interrupt delivery */
 	imsic_local_delivery(true);
+}
+
+static int imsic_starting_cpu(unsigned int cpu)
+{
+	/* Mark per-CPU IMSIC state as online */
+	imsic_state_online();
+
+	/* Enable per-CPU parent interrupt */
+	enable_percpu_irq(imsic_parent_irq,
+			  irq_get_trigger_type(imsic_parent_irq));
+
+	/* Restore the imsic reg */
+	imsic_restore();
 
 	return 0;
 }
@@ -143,6 +151,22 @@ static int imsic_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int imsic_pm_notifier(struct notifier_block *self, unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case CPU_PM_EXIT:
+		/* Restore the imsic reg */
+		imsic_restore();
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block imsic_pm_notifier_block = {
+	.notifier_call = imsic_pm_notifier,
+};
+
 static int __init imsic_early_probe(struct fwnode_handle *fwnode)
 {
 	struct irq_domain *domain;
@@ -180,7 +204,7 @@ static int __init imsic_early_probe(struct fwnode_handle *fwnode)
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/riscv/imsic:starting",
 			  imsic_starting_cpu, imsic_dying_cpu);
 
-	return 0;
+	return cpu_pm_register_notifier(&imsic_pm_notifier_block);
 }
 
 static int __init imsic_early_dt_init(struct device_node *node, struct device_node *parent)
-- 
2.17.1


