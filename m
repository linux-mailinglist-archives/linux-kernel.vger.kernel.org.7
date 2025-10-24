Return-Path: <linux-kernel+bounces-868407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57608C05170
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F0E189190D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA021309EFE;
	Fri, 24 Oct 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYWwM6Yp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F94306B25
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761295031; cv=none; b=clHte0r697qlmsyjlnISHcTBei7CeTpwXyjIGgCheDt1p3f8eUo3j/EH4y3iwBzwZZ6rZ0kqRV4R9WoayalupqsE85zs2BomAZuuTpH9WHI+1OJ7XHnU+o/xadOuPhYR0FIUKsIuK5Y79lLSQWTDWwhs5EN8KdiBbWJb90GC97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761295031; c=relaxed/simple;
	bh=naIGJgRf/5Gn324ht0cLPWhi94auIFknUkjHFY6rJh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaGnivA4f8FaFokfl1umeo86JsoY7iwMct6UHTNO/07Z7QmSS7bj7yfNoGOMYLX3aptI2Lpze1QchpV4LNrqYS3eCHLmlUlSaiwL/qL6nJ2KOhlG2XHCzcYjk1fCiE1bRT1Lev8lXNtjByiBFXY7z1TZS5dIu/T+ElHtYBk+pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYWwM6Yp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761295028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7g4pB/ckzo2nT8cxJ/9GjBhmxVVtiakBTxXeOu6fIr0=;
	b=OYWwM6YpjUHVP33HRARH3t1VHXH7rxKHD93M3uNmvRlptW9hIyzUIkEaHDGkrpJzHPu6O0
	0D6JwxuDL/chFNXyuMgBj3OdirzcbiP52BF6xsHkKovZTM0R2Myfp4JNRwPLlRtVQLBDsA
	oEif3iuDQToAaPf+FjM4TQ7KmVirseA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-7_vwuoKgPCyN_dQrnUqhCg-1; Fri, 24 Oct 2025 04:37:07 -0400
X-MC-Unique: 7_vwuoKgPCyN_dQrnUqhCg-1
X-Mimecast-MFC-AGG-ID: 7_vwuoKgPCyN_dQrnUqhCg_1761295026
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47114d373d5so13630535e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761295025; x=1761899825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7g4pB/ckzo2nT8cxJ/9GjBhmxVVtiakBTxXeOu6fIr0=;
        b=rmxvyq/PzpZQF80ODoB5VDDgENnpV3nQl6xjo2DXhfHbUT4cczaaoq7f5QZbFAuosf
         +LPv/9hC1KGpeYvsBHEQsWSCvwDvhv19N1PKR5AoswrbztPCl5I+O/PX6GLRnLRnUrza
         alj0GlEwnNkz3zqCuFMJnlsCRIYtChfI2mTHqcABWY4VnYIcLmyXYkqG/v4v39t2/Kty
         nCnd2eWLhe0mVHAg9SpEtGGRMfmC+AJLuw3s2hrCIbFZLKZ3jpUJt4p2FZaDlf9dKArs
         fONERKYA0k9dUTdNNpnrWddaWUHXu8yfDw/qrj52pa5Yi/6djACtk3iKD7ArBtCxpQW7
         9OIg==
X-Gm-Message-State: AOJu0YzfoTpPodhLGu7WX+zpofrlbKSRsYHfbEk+pnelEch+XHLkIVxj
	T9SnhRMtP/DtEvus4Ys48aYAAvz6XmFH539xE7XLYLLEjwQ59l3Wbwn67exhq9he/IpsJfIOXdA
	bLzOJC/r5JOveZ5pe0LJLKF3gYsXVCvcjgqqL0g+aeW0Uniy/qD3Yw47ijMJj2O4Qpn3LlkYBz0
	xZChTww9KZdxMS0tpm41daUjlvkF/10zxdLNL+Os1MLSypkng0T+Ch
X-Gm-Gg: ASbGnctS6Eypp7Nvhlg5CwQYeP8R+zFwcZN2te5NIKr2bPjpx6ykrKSmy2FICh4fy0V
	1jHUMmgO7wNZZwo45C6Hv8H8dq2DCWSVc3Ku2qopI6cRyyfGu3CWKI47tqIx9uNdLzkN0Ln3/Cc
	Sp6i3w/66Dr6BxrAxyCuQ53Sj62uA1Q91YeZy66gmNaKvLTOUOUEJfxeDyoKznf8edoRnT8PmsR
	8s8VPfZUDxq6lo9fB3YA7rXAUbWMPsgWyDmwjvcSuVWqS7En7GVe1rLzRg5UupbEIl994IT0Esq
	ImTrcb8Vkj3FpMp3FcYgmmvRiPQNw6EMmNRxcry6MiC/frPPP7WXhaI1HW7O5UCDUa/0P1RHYY0
	DT5qo8zA6
X-Received: by 2002:a05:600c:540c:b0:46e:46c8:edac with SMTP id 5b1f17b1804b1-471178a6f9emr188687565e9.11.1761295025567;
        Fri, 24 Oct 2025 01:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiPue6isAM3o8JvoJrHWMiOPf245L3GHD9ByxXO2p2tubIKm8/8NW9BN4YedrYR2Oo1SzNPQ==
X-Received: by 2002:a05:600c:540c:b0:46e:46c8:edac with SMTP id 5b1f17b1804b1-471178a6f9emr188686995e9.11.1761295025004;
        Fri, 24 Oct 2025 01:37:05 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e77dasm8111636f8f.2.2025.10.24.01.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 01:37:04 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH v6 3/4] irqchip/plic: enable optimization of interrupt enable state
Date: Fri, 24 Oct 2025 09:36:42 +0100
Message-ID: <20251024083647.475239-4-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024083647.475239-1-lzampier@redhat.com>
References: <20251024083647.475239-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Mirabile <cmirabil@redhat.com>

Optimize the PLIC driver by maintaining the interrupt enable state in
the handler's enable_save array during normal operation rather than only
during suspend/resume. This eliminates the need to read enable registers
during suspend and makes the enable state immediately available for
other optimizations.

Modify __plic_toggle() to take a handler pointer instead of enable_base,
allowing it to update both the hardware registers and the cached
enable_save state atomically within the existing enable_lock protection.

Remove the suspend-time enable register reading since enable_save now
always reflects the current state.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 36 +++++++++++--------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cbd7697bc1481..d518a8b468742 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -94,15 +94,22 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
 
-static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
+static void __plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 {
-	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
+	u32 __iomem *base = handler->enable_base;
 	u32 hwirq_mask = 1 << (hwirq % 32);
+	int group = hwirq / 32;
+	u32 value;
+
+	value = readl(base + group);
 
 	if (enable)
-		writel(readl(reg) | hwirq_mask, reg);
+		value |= hwirq_mask;
 	else
-		writel(readl(reg) & ~hwirq_mask, reg);
+		value &= ~hwirq_mask;
+
+	handler->enable_save[group] = value;
+	writel(value, base + group);
 }
 
 static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
@@ -110,7 +117,7 @@ static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&handler->enable_lock, flags);
-	__plic_toggle(handler->enable_base, hwirq, enable);
+	__plic_toggle(handler, hwirq, enable);
 	raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
 }
 
@@ -247,33 +254,16 @@ static int plic_irq_set_type(struct irq_data *d, unsigned int type)
 
 static int plic_irq_suspend(void)
 {
-	unsigned int i, cpu;
-	unsigned long flags;
-	u32 __iomem *reg;
 	struct plic_priv *priv;
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
 	/* irq ID 0 is reserved */
-	for (i = 1; i < priv->nr_irqs; i++) {
+	for (unsigned int i = 1; i < priv->nr_irqs; i++) {
 		__assign_bit(i, priv->prio_save,
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
 
-	for_each_present_cpu(cpu) {
-		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
-
-		if (!handler->present)
-			continue;
-
-		raw_spin_lock_irqsave(&handler->enable_lock, flags);
-		for (i = 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
-			reg = handler->enable_base + i * sizeof(u32);
-			handler->enable_save[i] = readl(reg);
-		}
-		raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
-	}
-
 	return 0;
 }

--
2.51.0


