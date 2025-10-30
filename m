Return-Path: <linux-kernel+bounces-878378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09CC2071B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9409718909F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B767239072;
	Thu, 30 Oct 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DGOCRQIC"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056225C804
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832642; cv=none; b=NV2zHi+769AuWC+7fOKj1r1xmgmbSDlLNLhNkGKCd0eMFb49ZAt+sJw4kT15Kvaiv95NWuIehDr0gAJdJ0C5Yp6QUJqCpsnO7+0KWZl6K+6t8Pcc8xiLLTuu8S0mDiWxqjvNn2N7TrqeHjNuwkQYVz35Gomja72A5PewrsAWrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832642; c=relaxed/simple;
	bh=ouiSQ/bYXMLTEPf/wq+/mgBpKqBW2VXDy5s0N6Y96sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMNaN4iW0W6CDyAxlYKl69b5doNAyguG2uXbt9eMr6nzVb1WLRW+bVQglZMmqeL57mBK9AHVc3e0ISVq4W3ULxNJof7/O363wj3HqCFLRJM8LwfzwZYm/GhxGSUhQfEli9I1hSWguLAtc8/X9P6yGh8yFt85Q2ZMmeUj6XKorKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DGOCRQIC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290ac2ef203so10568075ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761832640; x=1762437440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBFEkcQ8xUvhwX9gDA9IWLN2BELZaEr5a/ByZItGkVU=;
        b=DGOCRQICoMScUp8gvg2m/OxCOWchI6aWx0Ui/q1Qj5IeWzP/ZvaQD/2GJg6VVeqdDO
         3Zp4mNk49HxK4jgGZh3zIWNFk32oLnIuHukL0VwhbzhoVcpHO01YJaafI7RRGCz+wUOA
         KtlNfd0LXloVdeKaBxUV00p6i/i3PW4of+t9B4Ekji+WPFUmoQNQpXgZIOuRwfGIN1hI
         dzbhwvEtEdzoxxJ6rKQWkuKh0e2gJMdkAJZNiO0I2xk7wmSFo0GNyPi8494x8LsoVZCQ
         l0Qk8VpQAdItGlebgccftyy5yy179fMckZYPL8W5IyGPI/v7RbXUCB7SCxkrdFiMXjfq
         dmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832640; x=1762437440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBFEkcQ8xUvhwX9gDA9IWLN2BELZaEr5a/ByZItGkVU=;
        b=WN81BhQ556eIHk647TTuHgL2sP/xMcIm9yDid8QbQGsZCLbV++ogDPaOHI50oF4oHw
         0UbXOQ4ylsPFh0dP4dMZXaVBB5+zN0r9FjrsYfdU62iwMPADoZKigST5v9EAe74dXVFT
         /qFKWoDi6/FGqR5xGZ5jnLpo9WrACx5H8kFdD1rWw+T8dxCMB/vsMehgTL05e5qKk4Jp
         TN2TqEIf/1q0kE85+7rnfd6XazaSwtjJC1LDmKNtiFchsWsXPNphbwoZvjEO8frKo+Ik
         FiKP9wlePJkdej6T+sIgmp0rw+ImXG6VDW3OUHQlTdZZIpDcZJcfAqbBdCTG4FDTF5pO
         1Ipg==
X-Forwarded-Encrypted: i=1; AJvYcCXBfirexukN6Iw+8w5r0zAal9BNqJ7pPGroVJfyAbjjBwxSKTidmVwCsrpAjZo4HDG/n3p82Q72KSHBRHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSbNfol0/i82MSUjZUirgHIgnJsmXsY/TJQitOLzcEnJo6/Jwj
	KeVFz9zQghjwELX8biXZQQ+UsKu8vKHrDibvm9Gaeo8SjvSYF2yTUpCdw0/FQEaJMRI=
X-Gm-Gg: ASbGncve3RlR2Xl9ZV7RGxp0Sj/GztMZCVv2J8AQtiicEz8a4/E7Z/QdptMYXWU+siT
	yIqIj7ebVJSeREYjJfOm3eBuj196ScAXBGuYTGak7Q7TW49LeaEiL2OFVso0LSXOgK2XMDHTVkG
	XUg6aJ5mQeHeE2519j4Q9V3hRWkxK1xElwYvwzmDMIhndGbSRgINxVCkOaKX4soR/WJ8rzFS4D1
	7w2vk66wwkj6LMVVJd6tZjiJnX9IgxvBNcz54XUWy+BT/Gq0F39bB8lL+h9UIRJEf31YFuSaRmd
	er86xYHsDBZBsrXN032NDpeZlYa+Ou1RyaBEoD84JFn4SNrGF0B7CTZbtJqg67T7AqbzwNccu/F
	jVJs3IUqieBX6QV5fKt6i5WAgggO1qKJgP/jHlT9p1js4UIqLB2nYDRe5S7RJoect+VFyIe9Jzt
	FnLCanz0y0fyS9mC6Swvy9WpEKCcJgq5hV09uvcocxF7KCBXzq40MUzUWK8f+kF70=
X-Google-Smtp-Source: AGHT+IEBVtXylNQASrr2YyG7D2Tj2EPDKv83suTEKGHYLNZD/7uPvsZga5WS/d7dp2LV6KOpbcdbCg==
X-Received: by 2002:a17:903:11d1:b0:294:e095:3d3a with SMTP id d9443c01a7336-294e0953f16mr72086945ad.24.1761832640241;
        Thu, 30 Oct 2025 06:57:20 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e495e8sm187071905ad.110.2025.10.30.06.57.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Oct 2025 06:57:19 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	apatel@ventanamicro.com,
	guoren@kernel.org
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v1 4/4] riscv: mm: Perform tlb flush during context_switch
Date: Thu, 30 Oct 2025 21:56:52 +0800
Message-ID: <20251030135652.63837-5-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251030135652.63837-1-luxu.kernel@bytedance.com>
References: <20251030135652.63837-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During context_switch, check the percpu tlb flush queue and lazily
perform tlb flush.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/tlbflush.h |  4 ++++
 arch/riscv/mm/context.c           |  6 ++++++
 arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index eed0abc405143..7735c36f13d9f 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -66,6 +66,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
 extern unsigned long tlb_flush_all_threshold;
+
+DECLARE_PER_CPU(bool, need_tlb_flush);
+void local_tlb_flush_queue_drain(void);
+
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 4d5792c3a8c19..82b743bc81e4c 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -199,6 +199,12 @@ static void set_mm_asid(struct mm_struct *mm, unsigned int cpu)
 
 	if (need_flush_tlb)
 		local_flush_tlb_all();
+
+	/* Paired with RISCV_FENCE in should_ipi_flush() */
+	RISCV_FENCE(w, r);
+
+	if (this_cpu_read(need_tlb_flush))
+		local_tlb_flush_queue_drain();
 }
 
 static void set_mm_noasid(struct mm_struct *mm)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index f4333c3a6d251..6592f72354df9 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -115,6 +115,8 @@ DEFINE_PER_CPU(struct tlb_flush_queue, tlb_flush_queue) = {
 	.len = 0,
 };
 
+DEFINE_PER_CPU(bool, need_tlb_flush) = false;
+
 static bool should_ipi_flush(int cpu, void *info)
 {
 	struct tlb_flush_queue *queue = per_cpu_ptr(&tlb_flush_queue, cpu);
@@ -134,6 +136,14 @@ static bool should_ipi_flush(int cpu, void *info)
 	}
 	raw_spin_unlock_irqrestore(&queue->lock, flags);
 
+	/* Ensure tlb flush info is queued before setting need_tlb_flush flag */
+	smp_wmb();
+
+	per_cpu(need_tlb_flush, cpu) = true;
+
+	/* Paired with RISCV_FENCE in set_mm_asid() */
+	RISCV_FENCE(w, r);
+
 	/* Recheck whether loaded_asid changed during enqueueing task */
 	if (per_cpu(loaded_asid, cpu) == d->asid)
 		return true;
@@ -146,6 +156,9 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	struct flush_tlb_range_data *d = info;
 
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
+
+	if (this_cpu_read(need_tlb_flush))
+		local_tlb_flush_queue_drain();
 }
 
 static inline unsigned long get_mm_asid(struct mm_struct *mm)
@@ -280,3 +293,24 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 	cpumask_clear(&batch->cpumask);
 }
+
+void local_tlb_flush_queue_drain(void)
+{
+	struct tlb_flush_queue *queue = this_cpu_ptr(&tlb_flush_queue);
+	struct flush_tlb_range_data *d;
+	unsigned int i;
+
+	this_cpu_write(need_tlb_flush, false);
+
+	/* Ensure clearing the need_tlb_flush flags before real tlb flush */
+	smp_wmb();
+
+	raw_spin_lock(&queue->lock);
+	for (i = 0; i < queue->len; i++) {
+		d = &queue->tasks[i];
+		local_flush_tlb_range_asid(d->start, d->size, d->stride,
+					   d->asid);
+	}
+	queue->len = 0;
+	raw_spin_unlock(&queue->lock);
+}
-- 
2.20.1


