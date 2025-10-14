Return-Path: <linux-kernel+bounces-853018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220BBBDA72A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73906427858
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6133928BAB9;
	Tue, 14 Oct 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CM87k1u3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEA301701
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456485; cv=none; b=tyRC8mPO/ZxbiX/BmwQ3ENwa8YmYc19TXukoUpqWUUskYZWIA6nfKb7isWuMJy5ac3mKMFu1wuitXc1rSdwDagkh4dQE7m8fnJP181Ij8FqARCM5m/SakV5Fa6aIUGOGivM34oQtuHkXln4tFOxdkP16qDQkQRRP2caksgK0gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456485; c=relaxed/simple;
	bh=KV9ucYdrSd7aV5THkg1HTTYQyvCfSHuotGgMSDPE0ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLIoWWCxurhxyrL4WCwVMJoY6DnQhi18AuqBGU0JIxy449wJUoyeQPwOdywzDQEnPDXSzxn6v0sz0v8YlyfRL9FC0mCL9z0exbB8qVz0Of5bPhwDXTfLSwWJ2Z9HRhVw0HxHdCFIRaCIADMFOQ96O88k1U2m+w0kOzUHveHlr6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CM87k1u3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760456482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7lZewkuBAVdyN4JZJP+nOAcqX15LbPPR5tHpYtIJSQ=;
	b=CM87k1u3pO+IkXnFjMTzOsRNnwoSEmsGm90qg+KKzAqzBeyJJGoMuDYjfqQ8l0nn1DppuC
	kKffMG5/CfAwILH6JYDoAcqMpmxCjQGoLsHagadISq7osV5M04ZzUL5HQCLXRm7aznFOBx
	ODCmA03JTCxXsAktHylkdSRSCcc9wKQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-RY8hdknLNviB9rTzAQLsMw-1; Tue, 14 Oct 2025 11:41:20 -0400
X-MC-Unique: RY8hdknLNviB9rTzAQLsMw-1
X-Mimecast-MFC-AGG-ID: RY8hdknLNviB9rTzAQLsMw_1760456478
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b5c6c817a95so25576166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456477; x=1761061277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7lZewkuBAVdyN4JZJP+nOAcqX15LbPPR5tHpYtIJSQ=;
        b=dJhsr6mnWF9mj5q0+8eYeT0iZp1HHzfPXEsNuqS/pdsmvbUtVVS+jHfzWt2WhcWnKJ
         /qmal7WKwwP5bdNKN3RpN0ZTC0rV/cMSoHBdzPCEh6X/bXcvUq8xs7FODLfrJHPBhLNM
         y2JK0KCsceyXeGm4MzVf/0tVJZiQtTm3Z1pC9kYXF8Ou47cBkLzwQosZ7x8WiGD2740u
         B/rhEfcOqmao3Jm+xvOkrDeL5D4hPkPBpFj0qsdGludqTPLf6a/2z4NJ7hKLfAjk0fcD
         SshFg8j5tp0NNVCv3oBrhQWZdz1n5npkTlOAf9yROSu5saJ9OYcq6D34MMneHf+IMEbo
         dN1A==
X-Gm-Message-State: AOJu0YyNTLWYBAwQX2hLGIVmGbMdXPdOft4he8QD/BMygPm5iqQcpNJ6
	qsPOqib4arjDxv77UGbCvjNbkojUCN/UtUPzbImMBrfEYIfA4CF7p08lVGznpevmRMVfL3dtVFB
	KNRqBbDDL/MEGl3P+oCjk3eiAzEP96rCaxP+npACE7KGMei1EowsUHgTAlMvtVCNN8tiDmoPvcn
	HQccnjrLfJhiaywEJpniOT6a8pMY4/aisTaGcVWy6cGPx0V60mwctu2p8=
X-Gm-Gg: ASbGncvqWYaunFBAzJ+goZ1uYUgIvXlhpsF+dZtyFGpjHorW/NoG2/Cl7y8pxwncUZM
	jaEbc7sF4hoIvnUuxUGSqw1/vAwh0WTZqM6gQzM32BagF6n7ebcwXqfZaILAOcSQlnrG5N95Po6
	Ej8QrZCiI09wQ8CZu/vNWRxt7coSFjAQRwCKqpHTuvIJx1LL18iMSIorgUHzV6sTEbVVTHjlw+L
	CAR+cQcAUjAWX4a1hgGTTzZUfzBJh5roxQcq3pE+mDdXG8ZQinMrFzJe1BqOh47vzVyyEIGbRh4
	npIxyOiYegSgkEDPYp9SZzlkXQy/sggvFNruLaueTxA8C7WkAA==
X-Received: by 2002:a17:906:c14c:b0:b49:96e4:183c with SMTP id a640c23a62f3a-b50a9a6cdebmr2459863066b.9.1760456477321;
        Tue, 14 Oct 2025 08:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxi3HOmmPdFAXXJcKIC3OMf7TwEi8WYlD9KX4pDU2Vz/Xka6zpLXX+wOVIoz+BKQRNnG1wDg==
X-Received: by 2002:a17:906:c14c:b0:b49:96e4:183c with SMTP id a640c23a62f3a-b50a9a6cdebmr2459858366b.9.1760456476812;
        Tue, 14 Oct 2025 08:41:16 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cba45b3cbsm7897866b.40.2025.10.14.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:41:16 -0700 (PDT)
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
Subject: [PATCH v3 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
Date: Tue, 14 Oct 2025 16:40:57 +0100
Message-ID: <20251014154100.168236-4-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014154100.168236-1-lzampier@redhat.com>
References: <20251014154100.168236-1-lzampier@redhat.com>
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

When the PLIC_QUIRK_CLAIM_REGISTER is present, a specialized handler
(plic_handle_irq_cp100) saves the enable state of all interrupts, disables
all interrupts except for the first pending one before reading the claim
register, and then restores the interrupts before further processing of
the claimed interrupt continues.

The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
This has no impact on other platforms.

Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71..1d528904b353 100644
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
+#define PLIC_QUIRK_CLAIM_REGISTER	1
 
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
+	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
 	{}
 };
 
@@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
 		}
 
 		if (global_setup) {
+			void (*handler_fn)(struct irq_desc *) = plic_handle_irq;
+			if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
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


