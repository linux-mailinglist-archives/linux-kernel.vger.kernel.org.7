Return-Path: <linux-kernel+bounces-829150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E734B96654
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A071B1739CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206922DFA4;
	Tue, 23 Sep 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqV9uNbT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7519E7E2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638651; cv=none; b=iKR7Hpcn5E7gqJqvkDd6dYZCDt0YNBr10hrFgRYLYdgCCocwBLCzEIZr4wkWiXviS9AFiVLVbtloCaCPpEmRmI6YdJhYZBbp1zbQhL+8WzXNu7rwj7DI7HXoi9SEcdMSNi1oCSmD6ITRwS6RNCqMzmAb1CwbnKjIW7juA7IIYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638651; c=relaxed/simple;
	bh=1f/iNpa8REp0q5IifN2/u+4le7ji9XIT3CznMWHDGTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jtWmO5u9icVddYeWbgvS9Kgu3L5B6QJMx6N2aJ28ViOOazr6AOFWwkZ/0s79+aW3PHvKMLtYs9PsL+5cOLmJqIQVPmrDjjBQYwJx4UYRJlZhN7rjYhcwl4QHMqOdrQHmdi924iieHX42Sg+9ihYZ0XYaO+5k7T/n0SzzOVZevHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqV9uNbT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AfHkQLmJzDaguPM1LLGZDRbh3ErHlcNdVQv+rG4OVec=;
	b=KqV9uNbTf1LbN7Fo1tAZUQb/hSk9/XIMvDmnUevfRVrDQHa28xEqh2yeT+GGpQ9/PkzXRB
	0dGKBRzOXDW/10yj+Gi9sfIm+y7YOaKSNCrqkofGH4het8yB1OabJz/hkLdW+e6tfl0A8B
	R8TIScknKX2sbTPqg0KXrPEuO36S+go=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-XBwemTxHNHaeH1OWcPoohg-1; Tue, 23 Sep 2025 10:44:07 -0400
X-MC-Unique: XBwemTxHNHaeH1OWcPoohg-1
X-Mimecast-MFC-AGG-ID: XBwemTxHNHaeH1OWcPoohg_1758638646
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so1727205e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638645; x=1759243445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfHkQLmJzDaguPM1LLGZDRbh3ErHlcNdVQv+rG4OVec=;
        b=s9U/4FJRAUJQ2mDLxbJpdZ0Mf2YAF0GInT9t4+EtLCx1hVuOKfLWUhEPXiCNHX9fb7
         miIgOpeess72Gm/oTtNDZQ4Qv/LnyBOErJPjwbBmazcfIs6YYy33zj3xqoMKG1HtM0uo
         lwXWkBer9XB1diYy6ZVkrN3MRlRhiDcE/+6ByWoTBkB0cpOX7BCKBy6gZLI2UNJ442x2
         PFIEzbhNyjVYc4hRrlZTXPocOOE3oy0DpWVaaHD8Z5Ip9hVp0G1W3r9YECA3EHvBMdYv
         FjsfTkWVm5DchX2aGjvQyQnE9P7ArR7AqnuDYaI/xDYi83Gq9/pzwQAEgIJD0cNrKTbo
         MZOA==
X-Gm-Message-State: AOJu0YwufrPjX5IO+MJuLB07m344Z4A7+RX1MAa9XyFIf5vkOloJIxXn
	3gwvw7lxFmr7E4OnzXppAFYKLpg7ZTZUIE7k7ooaN30/js+fAG+Y98JKrnxM7uhB+kcuP7TkN4i
	ttvrD88UdLsLt3xNGkG2s6PWNyvZXvyNhcDLyDvdCzF0sebEMPulI6dqsl1YTWOXyqN6S+qbqOl
	atFMEtEeoq2o/RyIKC4uXwoKgZrexxAb//pponw54TeDHdN6MMueg/
X-Gm-Gg: ASbGncs4XAUwpZUUOpGd9bEaqgE/UbUGPkt1/h4KmTvK52eJqwm7oXaTd25vxTPGGEo
	4wk/L5B2zaog/q/xRUBOL+MVfZpCVojhbmFwyYuWdzmQfnuNfMRRFblUcysR+Bde5SDtkWWd/oF
	gEl1hnQxfbgsM4k2kWlbG66aSqDO8FA6EkFla4btggxKNMlc3ESePPzPVVnbJnKjH51KCnCDNko
	NFP0Zg4t8VFybLIdG0XVstdZLLwn3Hl1h4iOoFCoZMjpi5OurEX7UCJb8IAaUfUrc0pJRmKkkUo
	MGIZvrhNEdnIOzcfb1Ip8S8+TpDa8P3Q0TCHNmvoZzAWJb+CUw==
X-Received: by 2002:a05:600c:4f42:b0:46e:1afb:b131 with SMTP id 5b1f17b1804b1-46e1d975235mr32497805e9.6.1758638645278;
        Tue, 23 Sep 2025 07:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtR/o9bQUXEdS+Oi31bQdhk8BctYD1m5Uah5+e9/ilwUN9948r0etgePRaDlcvqrdV4w3WVA==
X-Received: by 2002:a05:600c:4f42:b0:46e:1afb:b131 with SMTP id 5b1f17b1804b1-46e1d975235mr32497385e9.6.1758638644622;
        Tue, 23 Sep 2025 07:44:04 -0700 (PDT)
Received: from holism.lzampier.com ([148.252.9.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbd63a2sm24054261f8f.48.2025.09.23.07.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:44:04 -0700 (PDT)
From: Lucas Zampieri <lzampier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	stable@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Jia Wang <wangjia@ultrarisc.com>,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH v2] irqchip/sifive-plic: avoid interrupt ID 0 handling during suspend/resume
Date: Tue, 23 Sep 2025 15:43:19 +0100
Message-ID: <20250923144319.955868-1-lzampier@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the PLIC specification[1], global interrupt sources are
assigned small unsigned integer identifiers beginning at the value 1.
An interrupt ID of 0 is reserved to mean "no interrupt".

The current plic_irq_resume() and plic_irq_suspend() functions incorrectly
start the loop from index 0, which accesses the register space for the
reserved interrupt ID 0.

Change the loop to start from index 1, skipping the reserved
interrupt ID 0 as per the PLIC specification.

This prevents potential undefined behavior when accessing the reserved
register space during suspend/resume cycles.

Link: https://github.com/riscv/riscv-plic-spec/releases/tag/1.0.0

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibernation")
Co-developed-by: Jia Wang <wangjia@ultrarisc.com>
Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
Co-developed-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
---
 drivers/irqchip/irq-sifive-plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bf69a4802b71e..9c4af7d588463 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -252,7 +252,8 @@ static int plic_irq_suspend(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	/* irq ID 0 is reserved */
+	for (i = 1; i < priv->nr_irqs; i++) {
 		__assign_bit(i, priv->prio_save,
 			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
 	}
@@ -283,7 +284,8 @@ static void plic_irq_resume(void)
 
 	priv = per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
 
-	for (i = 0; i < priv->nr_irqs; i++) {
+	/* irq ID 0 is reserved */
+	for (i = 1; i < priv->nr_irqs; i++) {
 		index = BIT_WORD(i);
 		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
 		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
-- 
2.51.0


