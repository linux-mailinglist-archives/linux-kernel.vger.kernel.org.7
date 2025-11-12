Return-Path: <linux-kernel+bounces-898031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A273C54225
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A87334257A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE911350A2F;
	Wed, 12 Nov 2025 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8cG4LGT"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3E3502B0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975470; cv=none; b=LkZvNaaDfAwUd6mOXGMQvuS10g00Rx8AWv5VDmQqTKFi3PNfpURDXyOcZQ4z7MTHihVnF7A3HgDVhbbBGdCXXEx8Hgx1yoRuE3IdTl2/74dXKdIEparDAX6YTivNyYrjflFdq3JnP7kqmi6sDZMAHTmXXXCAlWz70cQOx81c43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975470; c=relaxed/simple;
	bh=U1wRohHj26D11My7hyn5Fjdv4sejotMbBGmzGh0UhXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xw6bjRyrSbosR75FORXEiVs9MFKpxVAfnaGdyq+5kKQd76AXP71aEbhy+vUk5tGgiCF52Ntc3JusbFdYAmCYPZ1CumalBcV+6rfic/rj+lnZ4CzcjkHGhsrhquejHorcYBeJ5Kxrlp9b23oYOvQCyehX7/7aXep6CFDSFAjNVAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8cG4LGT; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6408222225eso1402a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762975467; x=1763580267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIoXEE+S06QHrqc9zlnHrp1tKevTOCIMWDXUdlSULxc=;
        b=i8cG4LGTFBIlpmu5dMCuJZ7Q48y2UjORI1YkwIz3f8jUKd92CDbSpPTIB7HuuF7enN
         vVJaQAZeDWTepgMuxGM8hnZlRfQ1dZMFvOkLbOkyhur91IZYVEdiP0+4iUtaFH3wJFb+
         I2faD2Bccfo5cQqS+Tq8lQ21c20lu4Xez4BS7f2fcYfC3Prx59MlMkZBGUrHLfUxooKO
         Qjw+wDMUPF7QTyeiVamr5Mx8UveqPGz7gtHpa2Ie8Cy4e1Iv0Js3JQ2EjYlkeCNbwChi
         RjI3V95c492yczXz9Plm/5l+mLRhwpu3X1imTd09RzmP00I1EeN1Frc2CpHBuh64447M
         Ut4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975467; x=1763580267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIoXEE+S06QHrqc9zlnHrp1tKevTOCIMWDXUdlSULxc=;
        b=D1TMOWzwkNPFma8x0eE1ZGhunjhXIecPbECUo+fH9kyqKqqwcsM6wkOzomMgGJU/mm
         G6Dioq5yumNvjX2IuvBwAa1TCsnD4D2BKh+4T2vwzjrTH0dj4ovHrxuWjvOrVQQCmkrJ
         hShLaCokn996iOrbboxu4zCBfqVR4BXyQo8+CLdMRTrGa1HL9XG2Fer6lvLH1c1ymO3F
         k/O++3DVZqpk1d7aFZItQBiefss0eyi9If3L6gJ2EtMKjRZmmCKQV2BrBLHXz88SY9tr
         7P2fyGw/vYYUqDD8+U3fcUWUYp+DN3PCUFOnh8fR/92xszNSapeFpnfclgi56+wzTCl+
         logA==
X-Gm-Message-State: AOJu0Yy+WixM1rq80BOV4vxA651asyNMb7yeG0AYblOIXfv+qZ7PphtK
	SYqhCrSqqGtAvJy3Ucd9yj388+8v5Sq4HZhLE5u2mnmnS49W2Xzb/LKd285CFoj1ZLsj9l9GF/Q
	v4BJqAw==
X-Google-Smtp-Source: AGHT+IFKilkduTNedmFbVR6dbNG+KpfIItVMFlp40IXZ01vb1nyeI/Op4xDBXuM1bNYEeMsk9RIyypHkw1k=
X-Received: from edok5.prod.google.com ([2002:aa7:c045:0:b0:640:9a27:321e])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:909:b0:63c:1170:656a
 with SMTP id 4fb4d7f45d1cf-6431a586af8mr3787278a12.37.1762975467428; Wed, 12
 Nov 2025 11:24:27 -0800 (PST)
Date: Wed, 12 Nov 2025 19:24:05 +0000
In-Reply-To: <20251112192408.3646835-1-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112192408.3646835-4-lrizzo@google.com>
Subject: [PATCH 3/6] genirq: soft_moderation: activate hooks in handle_irq_event()
From: Luigi Rizzo <lrizzo@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

Activate soft_moderation via the hooks in handle_irq_event()
and per-CPU and irq_desc initialization.

This change only implements fixed moderation. It needs to be
explicitly enabled at runtime on individual interrupts.

Example (kernel built with CONFIG_SOFT_IRQ_MODERATION=y)

  # enable fixed moderation
  echo "delay_us=400" > /proc/irq/soft_moderation

  # enable on network interrupts (change name as appropriate)
  echo on | tee /proc/irq/*/*eth*/../soft_moderation

  # show it works by looking at counters in /proc/irq/soft_moderation
  cat /proc/irq/soft_moderation

  # Show runtime impact on ping times changing delay_us
  ping -n -f -q -c 1000 ${some_nearby_host}
  echo "delay_us=100" > /proc/irq/soft_moderation
  ping -n -f -q -c 1000 ${some_nearby_host}

Configuration via module parameters (irq_moderation.${name}=${value}) or
echo "${name}=${value}" > /proc/irq/soft_moderation)

delay_us   0=off, range 1-500, default 100
  how long an interrupt is disabled after it fires. Small values are
  accumulated until they are large enough, e.g. 10us. As an example, a 2us value
  means that the timer is set only every 5 interrupts.

timer_rounds  0-20, default 0
  How many extra timer runs before re-enabling interrupts. This allows
  reducing the number of MSI interrupts while keeping delay_us small.
  This is similar to the "napi_defer_hard_irqs" option in NAPI, but with
  some subtle differences (e.g. here the number of rounds is
  deterministic, and interrupts are disabled at MSI level).

Change-Id: I47c5059ad537fcb9561f924620cf68e1d648aae6
---
 arch/x86/kernel/cpu/common.c | 1 +
 drivers/irqchip/irq-gic-v3.c | 2 ++
 kernel/irq/handle.c          | 3 +++
 kernel/irq/irqdesc.c         | 1 +
 4 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 02d97834a1d4d..1953419fde6ff 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2440,6 +2440,7 @@ void cpu_init(void)
 
 		intel_posted_msi_init();
 	}
+	irq_moderation_percpu_init();
 
 	mmgrab(&init_mm);
 	cur->active_mm = &init_mm;
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3de351e66ee84..902bcbf9d85d8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1226,6 +1226,8 @@ static void gic_cpu_sys_reg_init(void)
 		WARN_ON(gic_dist_security_disabled() != cpus_have_security_disabled);
 	}
 
+	irq_moderation_percpu_init();
+
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
 	 * its reset value (and with a value large enough to prevent
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index e103451243a0b..2cacceaaea9d0 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -12,6 +12,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
+#include <linux/irq_moderation.h>
 #include <linux/kernel_stat.h>
 
 #include <asm/irq_regs.h>
@@ -254,9 +255,11 @@ irqreturn_t handle_irq_event(struct irq_desc *desc)
 	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	raw_spin_unlock(&desc->lock);
 
+	irq_moderation_hook(desc); /* may disable irq so must run unlocked */
 	ret = handle_irq_event_percpu(desc);
 
 	raw_spin_lock(&desc->lock);
+	irq_moderation_epilogue(desc); /* start moderation timer if needed */
 	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	return ret;
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3014b5f..e3efbecf5b937 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -134,6 +134,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc->tot_count = 0;
 	desc->name = NULL;
 	desc->owner = owner;
+	irq_moderation_init_fields(desc);
 	for_each_possible_cpu(cpu)
 		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
-- 
2.51.2.1041.gc1ab5b90ca-goog


