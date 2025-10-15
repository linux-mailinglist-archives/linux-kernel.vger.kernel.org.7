Return-Path: <linux-kernel+bounces-854673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C5BDF17E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5551F4860F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1F12C2377;
	Wed, 15 Oct 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIOWQqQQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53A2BD024
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538686; cv=none; b=Zpk50wsOkwADSiurwNcNk52fMbTX1gpc8L2iIcFZB8NzWebCEkSOFW7vlm363QNlt/a3FSjqohGqa39L3O9miJO4OBofNzTjbqbB6lbVKwNh46q9X6N3zEKzQNrF1ah/q+OLT9mvq55B3T12SeBnPuTCOl1iBwQSuS7SoZzE5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538686; c=relaxed/simple;
	bh=AcY2f4MlAAdbgw8jaDNOVSExq4kwIaO5QnCF7RkLa3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txAPRDjiPBmTMxBrNXQVO+eHaau+RUoUJABtm4OddsnyM3q64FIK9MpRavgqeBBx758147P5fsUD4aXR7UQfpv1wI7bARdBKi+EyOb5yNWPvzajFJyZc4royOrFqKTMsviHWaTNU6rWdfjoajzArQpNk8Ua/qUt7cyH4UiZWsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIOWQqQQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760538682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ3PbqPH/LPP3qCouoXc35gFS4lh1EqDc5ueYOQ4ME8=;
	b=fIOWQqQQUkEb5PbZ72I+PXZWopZY98tHBw/nsLnCsxiChOcep1y4QFD7Z6fOFGUzVOiQkb
	KftmHLkAG/O2HA5mY6A01YTcKS5K2e9KHbYB5H7+yJ7uRmKKxZPSEK6v4v6dk4/VRcvVoA
	h/HbuvTbzTo+UnltStoT2kRM+PhugvY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-O_v8hcflMDeZtdjQCdpIow-1; Wed, 15 Oct 2025 10:31:21 -0400
X-MC-Unique: O_v8hcflMDeZtdjQCdpIow-1
X-Mimecast-MFC-AGG-ID: O_v8hcflMDeZtdjQCdpIow_1760538680
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47107fcb257so3219945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538680; x=1761143480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ3PbqPH/LPP3qCouoXc35gFS4lh1EqDc5ueYOQ4ME8=;
        b=xTXsRZzzLp7k1xvBq7eSE8b4lxIaejtAywa7VAnAvd1PRgQv3S2BUIePLSL+/MTTg8
         JQ/hlqdcqWtuBesGsx0oic64diYZXLS1recBZgLTVsguE5+3ShMjPFxAvGQFNF5xny/R
         hRrOR9UUl3tnJdwJwwpTg8XysxF63stnc7dF9E+UVS5WSyEXwvmZVflC9gZIILmnu4f/
         PwXCNDa2/O6j3Tc2DsMBYKVz/viIyEiln5VDQ8Atr4RcMeEslg7oIXzaTHzOIvmdnbqQ
         SH+40wtcmbKS/8fsSGDL51oY8DRlSDWHVQhJm467F3fhHwtAyXyqMcPjYyfwR+kEE0Y2
         gq0w==
X-Gm-Message-State: AOJu0Yy0wSLVOsoeld34ILTHguGKlvaeFVEjhjYHxpKwKAALcG8G4tiy
	fsHf6yf6oUd7lnJkFyMWizG/RTfUg1E45rCN9gcBI0qhrPYrbLa2+Y7Njzh2F/Y3AV5U24EjAnj
	bIuSg+1K93bIkKSH5aSocW0YwpqgVJlIm96dPkjclrs7TZMlhxsmJ87lrlqH2ZBUVC89DzXMKw7
	qE9nJ50KrMiBpKhwsbY6SB0mqU6KiiThRTxFgwpxHABaoCqxHmiM0J
X-Gm-Gg: ASbGncsEk0ZlYHNia7dMl/tn3q8ek9m7V3H1dY1NEm4ftKgIjv2UmI1Msz4ES3/Urt3
	13LZpkKZ/00GWPwdzuX7wp2B4eItrNWdGQxmlsK4QIf8nzPfduzZzlV2/c5COl2eZgF4EC1kfuW
	aG6sUgGLw7MLxreX92Y7dMX9e8n8ZKqz/dIwteVKHjiwyIeelcIeQLcqQBzc1D5WEcW2uft9yk5
	pc6QwhLHXfN1yeX1sl33sC+iXjY4pFxaTrvCFJle4YtgefO/vE4AiHqjkHyAA9OIYW3hjShKpKd
	oJs12gUISiq4MK8PqB4oLDU7jaYIwib7NJ9S+6hCNy7oTMOn5UH0JAs=
X-Received: by 2002:a05:600d:420d:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46fa9af9041mr215935025e9.22.1760538679926;
        Wed, 15 Oct 2025 07:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLp6f6711sgQUKuizHpqV871t5JrC5QuuNz5v7X1cxT23Pw64P4dbArMvd8WIxfdbe/kLA1w==
X-Received: by 2002:a05:600d:420d:b0:45d:cfee:7058 with SMTP id 5b1f17b1804b1-46fa9af9041mr215934555e9.22.1760538679364;
        Wed, 15 Oct 2025 07:31:19 -0700 (PDT)
Received: from holism.lzampier.com ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101c02377sm32617005e9.6.2025.10.15.07.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:31:18 -0700 (PDT)
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
Subject: [PATCH v4 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
Date: Wed, 15 Oct 2025 15:31:07 +0100
Message-ID: <20251015143108.441291-4-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015143108.441291-1-lzampier@redhat.com>
References: <20251015143108.441291-1-lzampier@redhat.com>
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
+		if (j == i)
+			/* Extract mask with lowest set bit */
+			new_mask = (pending_irqs & -pending_irqs);
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
+	void __iomem *enable = handler->enable_base;
+	void __iomem *pending = handler->priv->regs + PENDING_BASE;
+	int nr_irqs = handler->priv->nr_irqs;
+	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
+	int i;
+	irq_hw_number_t hwirq = 0;
+
+	raw_spin_lock(&handler->enable_lock);
+
+	/* Save current interrupt enable state */
+	for (i = 0; i < nr_irq_groups; i++)
+		handler->enable_save[i] = readl_relaxed(enable + i * sizeof(u32));
+
+	if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_save, pending, enable))
+		goto out;
+
+	hwirq = readl(claim);
+
+	/* Restore previous state */
+	for (i = 0; i < nr_irq_groups; i++)
+		writel_relaxed(handler->enable_save[i], enable + i * sizeof(u32));
+out:
+	raw_spin_unlock(&handler->enable_lock);
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
+		int err = generic_handle_domain_irq(handler->priv->irqdomain,
+						    hwirq);
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


