Return-Path: <linux-kernel+bounces-867134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC6C01ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC933BB75E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE231D758;
	Thu, 23 Oct 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFS4KH6g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7332B9B8
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761228080; cv=none; b=RSDZKQicA5mzqvWJQRAkkm2WSK+unOd4rruMhF9x7XFipXNDboC7n2NtWJc4jkcVOnTjnz6v9xaOpaSvg0wL13lqKu2rnpnnTlOnjLYeIy0owbbJQbDNUNouhz1YXVKg1uM/YaOT1nsbZu7tGF2eC8cvqzaVLUBtstEDArZtiUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761228080; c=relaxed/simple;
	bh=K2HhgskP3H/4M/wjnZbsRyaDQCuBFj5Hdoc9ZE42YzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ml+HbB3scCiBAj0aJtm9bp6jSwIrXyHyj91QfHLazMJnMtCvwg9WJoGP5r8bXYkgda3MES72yFq7PbnofFuYxNFLZWQQnVf4WpxkUtKU9BsC2dvjCQcUHT8gW+aahlsUJSUvJ+E5r3fjIbHn+XQRLTCv5x3sIIKhsQrQpZlUGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFS4KH6g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761228077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5IT49IQx4naO1r1BdT6bWbCUaLMDI3v7xXAjUka+ohY=;
	b=jFS4KH6gShwEA7kInyNDFlm+C8/6r4Ur0ex6Vjltgfk3Uz12fozLioBaX2JonuKwfedtY+
	DBJ5Re2rXhglgP8HB8n7GVBvsYAXpsxcGG2z82OMI3Ye5l+vp4okn9KirPnxZeT3oaBMwZ
	F+FZa4ma8jA6+ZRWVhDpwkuXshxx2Dc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-8ZaCEs6lP-mGYVIwWqA2Cg-1; Thu, 23 Oct 2025 10:01:15 -0400
X-MC-Unique: 8ZaCEs6lP-mGYVIwWqA2Cg-1
X-Mimecast-MFC-AGG-ID: 8ZaCEs6lP-mGYVIwWqA2Cg_1761228073
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso7196105e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228073; x=1761832873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IT49IQx4naO1r1BdT6bWbCUaLMDI3v7xXAjUka+ohY=;
        b=Nqlg7b/P1GDLnwhLZWybDwztWoSHTXWJcp5Mz1j+0SpUXsv62UtnowM3/BZ2ENcxNZ
         5Q/ecBTUYIvbrWwIRc3rMKayo/EWPIEOhMp/Lyfl7+ZUgKpJPFzxUimV6AAcjQdBMEmd
         Nq8wuKrD48HUyqDQlV0VYuyiWlgzcOdqvlXBtso8xN9gxskdopis1WRRzx2iKL7LH1yL
         WlzdvVj5KxGurjdWMPFWxYk2z9nbHl6DGHgEyI63kHWUV+YHHX6s+4UfFevpJiU2+3vb
         yFSFPG8z9E0QFSnJusrsHEBUD4x52MxnHhWjt9VVTeT8yu9ylUN+akY1Rk/V5czvLlLy
         ogfQ==
X-Gm-Message-State: AOJu0YzJF7AhmWtlXyD6yI2Kl/E0CAvYyUsylfWpLpCB/4+1dhakHqFF
	Cql3n29NArsbBO1/SjrEz4KhrtibP6nPq08pZ5VQEdhIvx7KFYrNJm3DyDrNwNCbvx0Hnzse5IN
	Uh1JJZbc3kgfWmBMksPB5wnZBQp0NNpSAAtJykS6IeKxndfX72690rfjevekV4ESX4YJWtc2Cuv
	rvRUiGjfuUZF/6N6jm/WWtPB+67pY0H0o9bu8YIUDWVIV2kyzGdhEQ
X-Gm-Gg: ASbGnct3ToD0zTuSPpuIhtNPwC+5R2ad4Mr2j1GrNqP9rF4eKwrKi1yOKJEhN9p7M18
	38Feh/q/vNZ093A6x0B0kibYviFp9JagbQp9BpF3qKwEVJX0vL/fK6wAzAediS1exzhq88Fl/AP
	CVp10M9nzaQd8YPykdH96/+Ui/yrGc3EN0OmYDmgI9E9HEE/oPNZ8okePCLWZtA3S1srOrHT9sy
	WnQM786rxuonIgkSrIKt98WFDhoh3mhrWQcUboxSIYu+t1F2fdC42QnzQ1GKCPNDmd45OspYF0P
	5IgZwgJgsnpKVXVV/dzFLp4bgudtFPi+zqLiRh2nVHti+x2bomNBbdjM5XlqK3UpEkYvTnzJzB4
	nUKo=
X-Received: by 2002:a05:600c:6c8e:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-475c6f183b0mr37332345e9.3.1761228073121;
        Thu, 23 Oct 2025 07:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbae4T7r1ZXH6ZnLz9LtKcRSlj8ttV3yrDM9CKplmHZhaoKpWNiXlFJi5xjQ8l5s4E2djLEg==
X-Received: by 2002:a05:600c:6c8e:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-475c6f183b0mr37331065e9.3.1761228071672;
        Thu, 23 Oct 2025 07:01:11 -0700 (PDT)
Received: from holism.Home ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898add96sm4116154f8f.30.2025.10.23.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:01:09 -0700 (PDT)
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
	Zhang Xincheng <zhangxincheng@ultrarisc.com>,
	Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH v6 4/4] irqchip/plic: add support for UltraRISC DP1000 PLIC
Date: Thu, 23 Oct 2025 15:00:53 +0100
Message-ID: <20251023140057.204439-5-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023140057.204439-1-lzampier@redhat.com>
References: <20251023140057.204439-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Mirabile <cmirabil@redhat.com>

Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
work around a known hardware bug with IRQ claiming in the UR-CP100 cores.

When claiming an interrupt on UR-CP100 cores, all other interrupts must be
disabled before the claim register is accessed to prevent incorrect
handling of the interrupt. This is a hardware bug in the CP100 core
implementation, not specific to the DP1000 SoC.

When the PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM flag is present, a
specialized handler (plic_handle_irq_cp100) saves the enable state of all
interrupts, disables all interrupts except for the first pending one before
reading the claim register, and then restores the interrupts before further
processing of the claimed interrupt continues.

This implementation leverages the enable_save optimization from the
previous patch, which maintains the current interrupt enable state in
memory, avoiding additional register reads during the workaround.

The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
This has no impact on other platforms.

Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Acked-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 116 +++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index d518a8b468742..786be200248f9 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -49,6 +49,8 @@
 #define CONTEXT_ENABLE_BASE		0x2000
 #define     CONTEXT_ENABLE_SIZE		0x80

+#define PENDING_BASE                    0x1000
+
 /*
  * Each hart context has a set of control registers associated with it.  Right
  * now there's only two: a source priority threshold over which the hart will
@@ -63,6 +65,7 @@
 #define	PLIC_ENABLE_THRESHOLD		0

 #define PLIC_QUIRK_EDGE_INTERRUPT	0
+#define PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM	1

 struct plic_priv {
 	struct fwnode_handle *fwnode;
@@ -388,6 +391,110 @@ static void plic_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static u32 cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
+				      u32 __iomem *pending,
+				      u32 __iomem *enable)
+{
+	u32 pending_irqs = 0;
+	int i, j;
+
+	/* Look for first pending interrupt */
+	for (i = 0; i < nr_irq_groups; i++) {
+		/* Any pending interrupts would be annihilated, so skip checking them */
+		if (!ie[i])
+			continue;
+
+		pending_irqs = ie[i] & readl_relaxed(pending + i);
+
+		if (pending_irqs)
+			break;
+	}
+
+	if (!pending_irqs)
+		return 0;
+
+	/* Isolate lowest set bit*/
+	pending_irqs &= -pending_irqs;
+
+	/* Disable all interrupts but the first pending one */
+	for (j = 0; j < nr_irq_groups; j++) {
+		u32 new_mask = j == i ? pending_irqs : 0;
+
+		/* If the new mask does not differ, skip writing it */
+		if (new_mask == ie[j])
+			continue;
+
+		writel_relaxed(new_mask, enable + j);
+	}
+
+	return pending_irqs;
+}
+
+static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
+					void __iomem *claim)
+{
+	int nr_irq_groups = DIV_ROUND_UP(handler->priv->nr_irqs, 32);
+	u32 __iomem *pending = handler->priv->regs + PENDING_BASE;
+	u32 __iomem *enable = handler->enable_base;
+	irq_hw_number_t hwirq = 0;
+	u32 iso_mask;
+	int i;
+
+	guard(raw_spinlock)(&handler->enable_lock);
+
+	/* Existing enable state is already cached in enable_save */
+	iso_mask = cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save, pending, enable);
+
+	if (!iso_mask)
+		return 0;
+
+	/*
+	 * Interrupts delievered to hardware still become pending, but only
+	 * interrupts that are both pending and enabled can be claimed.
+	 * Clearing enable bit for all interrupts but the first pending one
+	 * avoids hardware bug that occurs during read from claim register
+	 * with more than one eligible interrupt.
+	 */
+	hwirq = readl(claim);
+
+	/* Restore previous state */
+	for (i = 0; i < nr_irq_groups; i++) {
+		u32 stored = handler->enable_save[i];
+		u32 written = i == hwirq / 32 ? iso_mask : 0;
+
+		/* If we did not need to change the mask, no need to change it back */
+		if (stored == written)
+			continue;
+
+		writel_relaxed(stored, enable + i);
+	}
+
+	return hwirq;
+}
+
+static void plic_handle_irq_cp100(struct irq_desc *desc)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
+	irq_hw_number_t hwirq;
+
+	WARN_ON_ONCE(!handler->present);
+
+	chained_irq_enter(chip, desc);
+
+	while ((hwirq = cp100_get_hwirq(handler, claim))) {
+		int err = generic_handle_domain_irq(handler->priv->irqdomain, hwirq);
+
+		if (unlikely(err)) {
+			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
+					    handler->priv->fwnode, hwirq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
 {
 	/* priority must be > threshold to trigger an interrupt */
@@ -424,6 +531,8 @@ static const struct of_device_id plic_match[] = {
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
 	{ .compatible = "thead,c900-plic",
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible = "ultrarisc,cp100-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
 	{}
 };
 
@@ -658,12 +767,17 @@ static int plic_probe(struct fwnode_handle *fwnode)
 		}

 		if (global_setup) {
+			void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
+
+			if (test_bit(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM, &handler->priv->plic_quirks))
+				handler_fn = plic_handle_irq_cp100;
+
 			/* Find parent domain and register chained handler */
 			domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
 			if (domain)
 				plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
 			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
+				irq_set_chained_handler(plic_parent_irq, handler_fn);

 			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 					  "irqchip/sifive/plic:starting",
-- 
2.51.0


