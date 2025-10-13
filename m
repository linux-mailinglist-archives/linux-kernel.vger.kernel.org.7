Return-Path: <linux-kernel+bounces-850425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76456BD2C06
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D68E3C2E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6082571A1;
	Mon, 13 Oct 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLSGta0Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE675258CF2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354166; cv=none; b=Ojs2rdAsJju4N4b4mEtcK22jOMX4thN84+BUTUoDx4Z11nXolGF9mE5jJXwtMarsdpG70Tkh2GXUJNrf5whEgBCCCu5oly1JR6wicCzO+z8N7DR9SZngDo6btGKkoO0gbCyIGVTkMlmYa3U3S+xVMG6Sz7ME6EvN7yikEL3mjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354166; c=relaxed/simple;
	bh=cmbZqIogkq/EcugIc5yZlLZ5u6vQ/5jndCzkg2Kiut8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeUtokB+GPsEAOgfLsmFD8hy1aETEcCEMu2W5bHk05psRNxCSH1z2SndZnm6QIeahQmg+MvP6a4GvCZHOOaKyTigZj4DM+cfMMQfPu7ARuMXGpHGEI5mX/e5TIsRVqLaRll+RtY0fCz6qg0QJY30LXXJfsDsQ+wYVvDQeVpARHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WLSGta0Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760354163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJHdo25GZsD//7L/M3VD6J/R1bZjkabZbJap+nii06E=;
	b=WLSGta0YNInW5uby6naC+VPhvNjRO+YbHiuGBXkiF1Kmdw7EQAJ3P08iHfnXHiJwFVzMkE
	2RKMrlGMEWAa07SFpw0WBAwji0DJNXKMp6SO7htWssBBB6RQDe0PQN6bDCgJL1iI1I/wGY
	/RZ0umenQcKJZTeeR4FUeG9h3BrCU9c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-7hMKnxxUMN2wETenLHQ2IQ-1; Mon, 13 Oct 2025 07:16:02 -0400
X-MC-Unique: 7hMKnxxUMN2wETenLHQ2IQ-1
X-Mimecast-MFC-AGG-ID: 7hMKnxxUMN2wETenLHQ2IQ_1760354162
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b479e43ad46so354592966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760354161; x=1760958961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJHdo25GZsD//7L/M3VD6J/R1bZjkabZbJap+nii06E=;
        b=mHa22cOG0OfniH7qgs+6nPSxxcqtKW4iRbOAkdTnXln3BCkoB7s1DnXrTehAbeMzru
         mFkCFcdTRWYskjj3dOA8eRGPxynlaWfzb2chU92jrdZLuyeXsdv9vBoyypLYeSOWw76W
         ngH0tx/4zDApc4Bbl5UGogswyPUOw88J1clWZHXdkQbcKKEU7CZU4jkrD4vhixkw0i0I
         ruB6eEht2F8qwxOJQJnzzB8h5n33TgcxqKoALSD5rDwgcrAkXtTCfyIM5d5hRQ7hbqsD
         UrSSkJYaUELs1/5D+5CMYAPf+zq5K4ng7HthpPuU3M6qi6GD1ywnvwTW6yCeF1Iziwts
         YnKg==
X-Gm-Message-State: AOJu0YzrO71GrV7QXLyYjs/bNHFkPvH1pmZEhuFRRnN+rW5ArW7VcwKY
	8n/jAOmo1iRjJRmVZhyxBQpgS8tq0AgPmyLzMxB63Ow3KF+WQ8xbpId+duJvKZf+jQ37weR6vqf
	GhdBGrcsvGlKV/IdW85dIjVF5GdPEQ5wzyVTrYhwAGNjqEQjbziW1yIIqb+2YO/dbJDeAAVpo/S
	KIbCz2QAQRYcY7zTQekwo3/MbbCqaq1vTYXheqLXDJHmDm8wJdESa1
X-Gm-Gg: ASbGnctifs5R14vDTyWcZ+Gz5tllxETSAvPHjbtjQNGfVTGeq9mqOsXudQJewI5QkSU
	LG3CNV3IiO9pG/mFCrrWfSkSwfyiq3Pj5KYF0R9iV/Qh8qF+qhtPYxCVoakesEI1L5Ui3oXUM1J
	wJ8/JSZcgJgbSQVDKaikfoKl77Gv174O5/ac6IdQ2fzMLqYbFlydPpqIvNRK39fXSfBkQqwX7j+
	gIAEDyUIFK4fZrjyaBT82e6OlGigiCRCY3oXwsiVvRlirCjIkXuqf88aiFbGMHTKFWgKl7s1U7L
	YD31bl4yGOexoR+nNDnvqP3lCV97p8M8fc0cnBoN+PKe
X-Received: by 2002:a17:907:72d4:b0:b3b:110c:d343 with SMTP id a640c23a62f3a-b50aa492035mr2038533266b.8.1760354161384;
        Mon, 13 Oct 2025 04:16:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn6EsnRzMIVPRRAZr3OXPszrSJigMPb3zDVKXGXSvsMfCtVFK0OGUSuhUEqOn+xPWfIgDpYw==
X-Received: by 2002:a17:907:72d4:b0:b3b:110c:d343 with SMTP id a640c23a62f3a-b50aa492035mr2038529666b.8.1760354160855;
        Mon, 13 Oct 2025 04:16:00 -0700 (PDT)
Received: from holism.Home ([2a06:5900:814a:ab00:c1c7:2e09:633d:e94e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cad8adsm917336966b.7.2025.10.13.04.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:16:00 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <dramforever@live.com>,
	linux-riscv@lists.infradead.org,
	Zhang Xincheng <zhangxincheng@ultrarisc.com>,
	Lucas Zampieri <lzampier@redhat.com>
Subject: [PATCH v2 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
Date: Mon, 13 Oct 2025 12:15:38 +0100
Message-ID: <20251013111539.2206477-4-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013111539.2206477-1-lzampier@redhat.com>
References: <20251013111539.2206477-1-lzampier@redhat.com>
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

The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
This has no impact on other platforms.

Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
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
+	{ .compatible = "ultrarisc,cp100-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
 	{}
 };

--
2.51.0


