Return-Path: <linux-kernel+bounces-855757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C36C3BE234C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8EEA4F6555
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51C330C37B;
	Thu, 16 Oct 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ocy4+CbI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F230ACFE
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760604207; cv=none; b=Xc9aVbOhf4xFctDcOlWL9iCfyR25+/W/du5ZGmLV6H1SKEkmcNYHG2r1Vzihy/XPjIUHRSnh7M0lz/vD7JFrc5NJ4WkNOpCo5RAqjP1JX3FBcoYbIHYfmtdoREHujpmqDM1pYEzpqpG1d5w2sS8C2jK0vt59Al9RFswuS24tvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760604207; c=relaxed/simple;
	bh=lo3XNgqHRfgF/0r5ZS5b6kNk9J2xXhQnGNi2YRY9P8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o07wHICYkjzID+A/ozvaW/WlKDeDO27Cu8MXTL/2Fpg8BV3lTdTqQTh9028LYG1PrO/kmNKUKoMlozMyTWii4Y//80Mx4+q79j4B76Rhm5ODLITYzTcBYGZJGe/WgA68cf+1yRQwRuyfEnmdp4KRMCsfwL3HF/1mN/xgbpNs0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ocy4+CbI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760604205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ax80nK+NKV6/YU/qBv9lphSIJ/vcwRTM2uSJVvNymrE=;
	b=Ocy4+CbI4dulRhNM3x9bjKdhkeihDOGcsWVTbcwPXBhmQIU0W+BAVPc26QTk+aWFrOQ6H6
	AOndHtIpT7dDe39xbFROMQYr/mFX45H86duTn27OGtREwvpzOSDZVJu5Z18FP2p+Ras45m
	UZVKmnmWatxmCcZI2+q9PS7Y6/mG1O8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-LEYFFdRKMhGPLY_L3ylPaQ-1; Thu, 16 Oct 2025 04:43:23 -0400
X-MC-Unique: LEYFFdRKMhGPLY_L3ylPaQ-1
X-Mimecast-MFC-AGG-ID: LEYFFdRKMhGPLY_L3ylPaQ_1760604203
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-470fcde7fedso3283595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760604202; x=1761209002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax80nK+NKV6/YU/qBv9lphSIJ/vcwRTM2uSJVvNymrE=;
        b=gkN+dni77MlZr6h9C8x5ziWqu5/sjNxEdZyvWLgQ/N4bHlQvIqT2u2h3mDCzzqxOkK
         PMLJNyuzmqohFIlou25ySoG3WUftyP0ItSC7khBLqK8w/MB7YBOriHDaXb9xeeAuUJa0
         moBFT4LyEy6j/lg35RDhz4gjg0uUlDUgYxP4UlttijaaIVURtY0MFYqAv1vM4vyeCRDV
         G7kcm+SCeXuWJ/MYpSDsZuxkfYph+s0Lo2ABaWQFtP8wgk195EuFz7p4PjBvVC2FaFGX
         3drdk+HwMeZJE44x4dFX2dFyocvq6j5envvII+ZXQYCUvbZKUny7JH8U7Rvwv4bpC+NG
         4Qng==
X-Gm-Message-State: AOJu0YxrKlmfezdk28qfAAc4LAyvJ0lZsL3EM2PUHvrI4ByaOweu5w7S
	VScUnypIQ2HR23ebKdQcLhjxXIPz9OtEo9xvNPVyCR8WVrMF27/ASNRdA5AQ0xgfBQ9UOTmmVNk
	LT3yg4le5r64HH6Ko0u+6v1LCFZJvXxt3j2rvuOAwMJdBeNWYgzKP/vs7KYQykvF/6S6EqnnNii
	OOcx2tgUOo9twfZ4v2eZv5rbDz++5FV+N8CJHnRZ5Z+0JSsEic8hJ1
X-Gm-Gg: ASbGncsWSzlQEdMEMBjvx82jZl3P+tyRIpVxNrxOIgZwgwBY4nIUK1YtqF4GbGigd/U
	ZQG4TxwiXEquTdVjTin2ye5MWzlBU+ravGA9ACl0su0GIjSMfCaeU6iJKiU59lDLr64tiNhVY0G
	t3/zdZEt8n/Ik149ADXkmxyDpcOGNV+Vq0ruLKWwQ+1ucerqd16+msa3+RBLol/CioxrwNbxZaT
	4Ixz8HJqP/xcQPrBHRq4a+LduWE89xSOaP+z447TZ+aIeY0KgQTkalDIyThXN7LbIe3ViO0nTFB
	0o6bRHGmM1wss3oY4i0NlDx2yk4aJjxtpZplC7OsDpKxdvVhe9dExL6q8udffR3cl1SPUzOL+Ht
	Cxbs/4Zqk
X-Received: by 2002:a05:6000:40c9:b0:426:d619:cac7 with SMTP id ffacd0b85a97d-426d619cd64mr12707403f8f.36.1760604202150;
        Thu, 16 Oct 2025 01:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE87h87L5+cjbKqDzFGeScqw+GJyAWKB/ZTf9y7pe94sr7jbGPA3jOKyUr3qhAx/eeHS0qseQ==
X-Received: by 2002:a05:6000:40c9:b0:426:d619:cac7 with SMTP id ffacd0b85a97d-426d619cd64mr12707369f8f.36.1760604201696;
        Thu, 16 Oct 2025 01:43:21 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm33047565f8f.45.2025.10.16.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 01:43:21 -0700 (PDT)
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
Subject: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
Date: Thu, 16 Oct 2025 09:42:56 +0100
Message-ID: <20251016084301.27670-4-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016084301.27670-1-lzampier@redhat.com>
References: <20251016084301.27670-1-lzampier@redhat.com>
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

When the PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM flag is present, a specialized
handler (plic_handle_irq_cp100) saves the enable state of all interrupts,
disables all interrupts except for the first pending one before reading the
claim register, and then restores the interrupts before further processing of
the claimed interrupt continues.

The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
This has no impact on other platforms.

Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Acked-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71..0428e9f3423d 100644
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
@@ -394,6 +397,89 @@ static void plic_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
+				       void __iomem *pending,
+				       void __iomem *enable)
+{
+	u32 pending_irqs = 0;
+	int i, j;
+
+	/* Look for first pending interrupt */
+	for (i = 0; i < nr_irq_groups; i++) {
+		pending_irqs = ie[i] & readl_relaxed(pending + i * sizeof(u32));
+		if (pending_irqs)
+			break;
+	}
+
+	if (!pending_irqs)
+		return false;
+
+	/* Disable all interrupts but the first pending one */
+	for (j = 0; j < nr_irq_groups; j++) {
+		u32 new_mask = 0;
+
+		if (j == i) {
+			/* Extract mask with lowest set bit */
+			new_mask = (pending_irqs & -pending_irqs);
+		}
+
+		writel_relaxed(new_mask, enable + j * sizeof(u32));
+	}
+
+	return true;
+}
+
+static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
+					void __iomem *claim)
+{
+	int nr_irq_groups = DIV_ROUND_UP(handler->priv->nr_irqs, 32);
+	void __iomem *pending = handler->priv->regs + PENDING_BASE;
+	void __iomem *enable = handler->enable_base;
+	irq_hw_number_t hwirq = 0;
+	int i;
+
+	guard(raw_spinlock)(&handler->enable_lock);
+
+	/* Save current interrupt enable state */
+	for (i = 0; i < nr_irq_groups; i++)
+		handler->enable_save[i] = readl_relaxed(enable + i * sizeof(u32));
+
+	if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save, pending, enable))
+		return 0;
+
+	hwirq = readl(claim);
+
+	/* Restore previous state */
+	for (i = 0; i < nr_irq_groups; i++)
+		writel_relaxed(handler->enable_save[i], enable + i * sizeof(u32));
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
@@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] = {
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
 	{ .compatible = "thead,c900-plic",
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible = "ultrarisc,cp100-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
 	{}
 };
 
@@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
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


