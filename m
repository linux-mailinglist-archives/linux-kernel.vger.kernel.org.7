Return-Path: <linux-kernel+bounces-846441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091CBBC8049
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DB4188413E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4182D193B;
	Thu,  9 Oct 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvYOafq+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0892D0C64
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998100; cv=none; b=TbfHkeQZ7Dbq4wrdQZhz2bEbHfojef6ZUuOaI2aNXMLPmIQSfT2ZPGiVEDw4n3ID4DNi6WgIQ4UvZNA/36wFpvHnnDYE72bMY3KWJ0hv2JkqbEPGWrQtWQT63RcS16bVYvqFUcEOnA5a+OJb/MsYvgdlAZD5BIk+fHgiD3mbQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998100; c=relaxed/simple;
	bh=I4/C0hevrRF7qsk9DBClCPPqEmARIzj8Ei9B5oJdnmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lt2ZzP8d14TGCnxfVz34+fJj0VASMBGil7PUQiwjvw3rcTTnFD6sc55k/U7s5AN4n7kqMeLx8OL604CY4ojcEBLcTPVDGdH22O29EtnDP/OgInhwQy2OeBLkVFPank7c9mYqN9u0G5W8SlRQu+jBtqf8qBKe4Yz0sa79sOHoFFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HvYOafq+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759998097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0xBvB4cpvYBkdw6YrbIjRmoTGZP8mUNMzyTE8hHEnM=;
	b=HvYOafq++5R+ZlMjDsXFJtN4TJprcPAG9MtGvi6XHkiEsInFCJj7k8N0jpLciTKUs1fSBX
	VUdfeMLqrayZKOBa9Q/peoYQtZ5/EimW3jkONOn3XvRzNGKIHKcAXbX7x3o6qC3DJxSwhc
	Ra8ELh7ESVwmR/pDgG1hWTgWtT8Asyk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-q-SakGDYMpqPZv1_D7RyLQ-1; Thu, 09 Oct 2025 04:21:36 -0400
X-MC-Unique: q-SakGDYMpqPZv1_D7RyLQ-1
X-Mimecast-MFC-AGG-ID: q-SakGDYMpqPZv1_D7RyLQ_1759998095
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b448c864d45so56173466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759998095; x=1760602895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0xBvB4cpvYBkdw6YrbIjRmoTGZP8mUNMzyTE8hHEnM=;
        b=fgdHsQMg/nhSarUadq86FtvZJHRmVbkUvI6x0wci9Y/DE/ceGOJx/RIm/SmdypvR1j
         kG9f+M5tLR63HB6KIbVFW50kiqN/oyot7b/N2izbUncT8j1OJFtnyw6Y1bs27vWInlze
         ixPuxEC9CXnL/mHqbQpFiqj8n9mzD0QLzmrKinT/GZnwywolgkFOM6D4Mse15NrbpveM
         jekgyhmrVZt7hjEZmMVQxy5hWyLj+MVBu3DaFqrKUzoRmnHfC6rtqJt1wHKQ8rCuQENt
         PCgN6PH6zgmGJ9p0bKxv6Pepz5EsiwkTSbqHQaW0bACTop2iyzMxBUOD+AppqTpgWR6f
         7CFg==
X-Gm-Message-State: AOJu0YzoFHsPZdZT4GpR4hicwrkiJwVf/v7nOW9lOTTiAz7yifu2JNFX
	DbAmBKCIJdyxyhfDJdfQtchp4M3o89Obeh74RFIEbn2Y8pY5eVutmzKkUMA3QLJenk0EhW9Q1nq
	I/e8xrAE1skdW98lsAwGIp2kB6x7Rrs46Yt7eHmY4SvXhvyvDZpZX6Hqj5D8fI+adNtQVVtwWG9
	mc35/Mxy0nEgjW/bKk3iU5bFvphct+f308A2z2AUmhdV9CGwSs3vHh
X-Gm-Gg: ASbGncvt1/f0rbqTy3aS5jvJtKuydqRny92JgyRMQmyTdiQV/lO27FbHH13R6EXLjNZ
	tp2DvFtm4H23eGx2Zc3pz8lHm8t0trN2At8Ws3rmu/Aa7fiNGyO3Fr4UixEY+lHCZPaoZC66vkk
	gUnrQdrDOndlbtvfFBL+XqLPvj3GaZt62diTN9eCzCJmbqHARF0I6YXs9ob9Wetlp7fzRzEo/6s
	5cyJxYYAhKsXupk9hHXw+AsH3v5OiAw/mOcTRGnv/VynBK1BiU00DuKZWgW7ZBJSD6DSV/NBsan
	ZfXOnDiaSjA9Yn5ABe0H1o24nqy/hy5hImx7t58/3v6vsE3ZxY7b
X-Received: by 2002:a17:907:94c3:b0:b45:8370:eefd with SMTP id a640c23a62f3a-b50a9a6be43mr649673566b.5.1759998094826;
        Thu, 09 Oct 2025 01:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX1ep1IfrGZOFezAFxpz/haghG7x5n4wwnI1Tqd535Iu6MiRVa/gtslelpEHIAmjcL2ZVWKA==
X-Received: by 2002:a17:907:94c3:b0:b45:8370:eefd with SMTP id a640c23a62f3a-b50a9a6be43mr649667966b.5.1759998094107;
        Thu, 09 Oct 2025 01:21:34 -0700 (PDT)
Received: from holism.redhat.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4e27dsm1832988266b.70.2025.10.09.01.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:21:33 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Zhang Xincheng <zhangxincheng@ultrarisc.com>
Subject: [PATCH 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
Date: Thu,  9 Oct 2025 09:20:13 +0100
Message-ID: <20251009082013.1331361-4-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009082013.1331361-1-lzampier@redhat.com>
References: <20251009082013.1331361-1-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Charles Mirabile <cmirabil@redhat.com>

Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
work around a known hardware bug with IRQ claiming.

When claiming an interrupt on the DP1000 PLIC all other interrupts must be
disabled before the claim register is accessed to prevent incorrect
handling of the interrupt.

When the PLIC_QUIRK_CLAIM_REGISTER is present, during plic_handle_irq
the enable state of all interrupts is saved and then all interrupts
except for the first pending one are disabled before reading the claim
register. The interrupts are then restored before further processing of
the claimed interrupt continues.

This modification matches "ultrarisc,dp1000-plic" and has no impact on
other platforms.

Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 83 ++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9c4af7d58846..a7b51a925e96 100644
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
@@ -367,6 +370,82 @@ static const struct irq_domain_ops plic_irqdomain_ops = {
 	.free		= irq_domain_free_irqs_top,
 };

+static bool dp1000_isolate_pending_irq(int nr_irq_groups, u32 ie[],
+				       void __iomem *pending,
+				       void __iomem *enable)
+{
+	u32 pending_irqs = 0;
+	int i, j;
+
+	/* Look for first pending interrupt */
+	for (i = 0; i < nr_irq_groups; i++) {
+		pending_irqs = ie[i] & readl(pending + i * sizeof(u32));
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
+		writel(new_mask, enable + j * sizeof(u32));
+	}
+
+	return true;
+}
+
+static irq_hw_number_t dp1000_get_hwirq(struct plic_handler *handler,
+					void __iomem *claim)
+{
+	void __iomem *enable = handler->enable_base;
+	void __iomem *pending = handler->priv->regs + PENDING_BASE;
+	int nr_irqs = handler->priv->nr_irqs;
+	int nr_irq_groups = DIV_ROUND_UP(nr_irqs, 32);
+	int i;
+	u32 ie[32] = { 0 };
+	irq_hw_number_t hwirq = 0;
+
+	raw_spin_lock(&handler->enable_lock);
+
+	/* Save current interrupt enable state */
+	for (i = 0; i < nr_irq_groups; i++)
+		ie[i] = readl(enable + i * sizeof(u32));
+
+	if (!dp1000_isolate_pending_irq(nr_irq_groups, ie, pending, enable))
+		goto out;
+
+	hwirq = readl(claim);
+
+	/* Restore previous state */
+	for (i = 0; i < nr_irq_groups; i++)
+		writel(ie[i], enable + i * sizeof(u32));
+out:
+	raw_spin_unlock(&handler->enable_lock);
+	return hwirq;
+}
+
+static irq_hw_number_t plic_get_hwirq(struct plic_handler *handler,
+				      void __iomem *claim)
+{
+	/*
+	 * Due to a hardware bug in the implementation of the claim register
+	 * in the UltraRISC DP1000 platform, other interrupts must be disabled
+	 * before reading the claim register and restored afterwards.
+	 */
+
+	if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handler->priv->plic_quirks))
+		return dp1000_get_hwirq(handler, claim);
+
+	return readl(claim);
+}
+
 /*
  * Handling an interrupt is a two-step process: first you claim the interrupt
  * by reading the claim register, then you complete the interrupt by writing
@@ -384,7 +463,7 @@ static void plic_handle_irq(struct irq_desc *desc)

 	chained_irq_enter(chip, desc);

-	while ((hwirq = readl(claim))) {
+	while ((hwirq = plic_get_hwirq(handler, claim))) {
 		int err = generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
 		if (unlikely(err)) {
@@ -432,6 +511,8 @@ static const struct of_device_id plic_match[] = {
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
 	{ .compatible = "thead,c900-plic",
 	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible = "ultrarisc,dp1000-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
 	{}
 };

--
2.51.0


