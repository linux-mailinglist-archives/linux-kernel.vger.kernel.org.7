Return-Path: <linux-kernel+bounces-722691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F550AFDDBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325331C26BF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE05C1DE8BE;
	Wed,  9 Jul 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Yn254tBI"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46A1DDC2C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029795; cv=none; b=hlnvUSAEPu4+TqmUQnQyEfS3L9EB6pcxM6Nwm4DYt0Rlx5gNPx1+cuybbKZudjVN1Z5sJ+2bY1rZ4qxN8txHKTF68PNsCB//6LSCbKt02xIsPv/4tfVwUATHdkX45NoUiX7hJdlEEoRETM+X8mYnN40CUaf9CafI4OM4DKXnJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029795; c=relaxed/simple;
	bh=e2xEWwImpYDUfzc8I6eTFB88OvA37klFDbCC3upXgWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gtk/msYoIa7HetWJIPPWgudw29Lcl76+WoXKGRrXjxl9BlCpbuBvErpWgiNXRYd4g/L37jSeQxiEpxb7k5dKrm6h6YFYxE80d6yiE5tAZLMtnR4l1m+GC4kiDnv/jx4rre6powiqsblMd0rOFYiVkh+Eg+bjFZebXeNJRD1sLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Yn254tBI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d45b80368dso530102185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1752029792; x=1752634592; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9U4brjiS3C32XW3bHVRt6PkxvPweR4nZGcE43NufvY=;
        b=Yn254tBIh2sWG7bB3Bo9Ccieq8wB5AvHaTng8tj7p5XqaeHyWFOsWROMMkJ9bLM4Eu
         N2zJ4u+t1MXDwyiQlx0Xg4TUfe2Qlnr4NDzZ6RHuGFPQtx5IkU5etG2/gP5rheUV286h
         2TFVokSV7BacxbGOAz9QgrBbLswv9XkyCxYV2dqwhsjtIrUIb3wSpCNldWUDH3sZcboj
         blcVaFV7iPSolUfestmkGzgTSroXG2WG6YZLlbhteFOggzzkqj/CyAfmI5T745nNF8Nh
         fZmX6bpAvEc8QeuqvAlJsZfErP1hpgfV5Mybn9gtXrjEZkjJ+sRKuKnvyNnxO9TjlMLH
         6akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029792; x=1752634592;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9U4brjiS3C32XW3bHVRt6PkxvPweR4nZGcE43NufvY=;
        b=wXDvsLZLwfRpf5QWHXUqiXFa1LgvOUJfUQiYPiHWPQpYo96JY6TiJhG5arBTCmhjvY
         vLaGSfZLWK80LfgOKGYmJ3UI4Dh1j3SsQ+lx7nl6V1Yum3VoFeRoCt9B0oh4neULBJn0
         3TNGb+bXzAANLUaBO/xrrHhCvhHdJzMqF+fye3wl1JATgtYJFe3MIDjz46A/Sus6Mfoa
         p1FqPXSozeru1jYq5Q5lys/0jsqDlkAF17SoNa2rf6bdYByeeOX73IWtcX/Ug8VB1ieO
         Bx+3HrT8GgBHrAOeFKtmONxObxM9rklyNj1gLSZuzbcD13+b9FOMsPnXbLOJ1flFlOx4
         xDhw==
X-Forwarded-Encrypted: i=1; AJvYcCXSdErkRH9zotET2jr6Hen0YK9Hwt0etwdUR15Oavv8HGzdHcBYY5sDJQQy6yrqz8LUp/lXSgDuKCOlIwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3x2V5dTHO44/fQl5SXXD676pYsiOJsBQGFVRB6CNjr9qe2mSX
	3G0hZgZq93O+FI0AuvFlAQwZBpD/HikQ4n1fAFymq0yNhuSqFDxwJAbz5Ju2cJhnGQE=
X-Gm-Gg: ASbGnct8+yE5rTSzdJJc1YcJm/WYemgQWWK7CStb/CZI6MNIXUxs4q3w9B3ie0pDrWo
	yR4E7b3NQnLxeD379Nt4YsgD5xPVFWGheEwbLswX4YiMJR726MxTtz6G1JWmZHUoztSsxLi/e+w
	H1P9z8dLAgSSRyaJs2ATSkUZ/i8/RLYybrww2qC2KY2bG0HAy1qI8ANW/uDMUxEnHcu9rqwyYPr
	bVUpnsnZoDGEcA4u/P/aTCyA/yTl1VwS44NonKypGqbFyvzjppV0wvOBBA8/nh7XmOF6xGbuLoE
	7fnuGOj0sbksD82DbhV9X01h6JFy1glfDrZ79zCaDyVWONyy5cL1qu0IMqbM9nleTdldQ2FQD3V
	6fCqH/rnQ
X-Google-Smtp-Source: AGHT+IG/O/VknzhuZDlGWIkLTbeQ76zvcAaRgDp06FmEoKv7tLit+X11x+afuO2aoaIdYNQmMzC1MQ==
X-Received: by 2002:a05:620a:4508:b0:7d4:70:908a with SMTP id af79cd13be357-7db7db70ce4mr163253085a.53.1752029792368;
        Tue, 08 Jul 2025 19:56:32 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb2318sm867257585a.107.2025.07.08.19.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:56:32 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 1/2] irqchip/riscv-imsic: Restore the IMSIC registers
Date: Wed,  9 Jul 2025 10:55:15 +0800
Message-Id: <20250709025516.28051-2-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250709025516.28051-1-nick.hu@sifive.com>
References: <20250709025516.28051-1-nick.hu@sifive.com>
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
---
 drivers/irqchip/irq-riscv-imsic-early.c | 41 ++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index d9ae87808651..f64d9a0642bb 100644
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
@@ -143,6 +151,23 @@ static int imsic_dying_cpu(unsigned int cpu)
 	return 0;
 }
 
+static int imsic_notifier(struct notifier_block *self, unsigned long cmd,
+			  void *v)
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
+static struct notifier_block imsic_notifier_block = {
+	.notifier_call = imsic_notifier,
+};
+
 static int __init imsic_early_probe(struct fwnode_handle *fwnode)
 {
 	struct irq_domain *domain;
@@ -180,7 +205,7 @@ static int __init imsic_early_probe(struct fwnode_handle *fwnode)
 	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/riscv/imsic:starting",
 			  imsic_starting_cpu, imsic_dying_cpu);
 
-	return 0;
+	return cpu_pm_register_notifier(&imsic_notifier_block);
 }
 
 static int __init imsic_early_dt_init(struct device_node *node, struct device_node *parent)
-- 
2.17.1


