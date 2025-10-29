Return-Path: <linux-kernel+bounces-875037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD22C180E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C75214FC32A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662482E173F;
	Wed, 29 Oct 2025 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6d/76TP"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EC1F0994
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705150; cv=none; b=iuWYu27zjuczLxUSj89RPm9B52QGkWknzHb8cr52WDO3LwInWasoSD25Gov0DuP4Dk5pgIvth11wGIPKL1xbT22Oscqh60fmKbRwVB29H2MBuoAf7dDb58yvqiSTxYzra3voVLb8IO5EfgkRNoaZcX7qrAGLAPRufPBuKUJ3HA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705150; c=relaxed/simple;
	bh=kJU0HHsz8RVc7g1I+1f1X0net62Vn5bTl5/+wnElJ50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iS+XgSR3owQnq39iVOW2bA1kulgI6CJoAqzT+M9yAMI5TJnn1Mtm29bqtwXJJ64SWEGcUVHcUSRD0BKXkaEXZTn8UeAxPzpExxNU3209HFzwxfFscdYsf2E8IoQKV80HId/i0pR3BruPUoYjVey/X7UNI0wbBUgeFDoltZlh4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6d/76TP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so5179612a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705148; x=1762309948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbaG5t0eQSgPX414bWojxTfff0IaUO9MDOrZ/xFSz38=;
        b=O6d/76TPW/tuiqYjgq8yng7Cu0siXycaf/U+jPR17iX16h7741ee4l3T8D/LHaUWH9
         mcWC98loTMeD/e6NcS8c9WW0Ibc0d3mQI3g+VeI+GSkQ49qumN26K/zZHBd7eG2QUKtD
         CCkdWj8Oqz2SDUYREtMqwQVbKu1bxBYhRX472HChcfBizRohh1C80n94E5jUtD4BplgY
         sfnwXQLic9Dj7eZGuEEwBPqe4LBAH3UVQOL/kfD3BDTR+nKa0n+wf3ceWwaUvW8UzvRH
         ODejwwpMLrVrgqst/+yoXnC7RCh/3d7ZQLW91zrwTXIhwkkt+JjbvvuAobjU4/hvD3Gg
         DCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705148; x=1762309948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbaG5t0eQSgPX414bWojxTfff0IaUO9MDOrZ/xFSz38=;
        b=oUq2X4/uqY7zG4Kg+NtgICdKM437Kxf6YlLnNZ/Q2rD613ldkVAj1wtO9zVXzOX7MB
         RkpP4ogoYOeMx/VToibCyw9GAP4st+8CvA9xNmwXIKB/8KOV0CcDSac7+jEI6zvtD8J7
         94VObOOXTHjTmOy44ykRMS9wQt1i90CNOFlXLxl0EFZ5WcVh2e8hk1kbyxCswiERhyRe
         HmOgrVNqzM1548IDQpqNU5yVZScMipTdweon4WQjZsg6nh8SDXWbOHRtIxW6+QmRWl3R
         SGvUHtHPOjoP8ASIcC5a89GwsOqyVVNo49a7dxO+EKLJBEDeO8tE+KEtLsx4OC65Aqrn
         YoXw==
X-Forwarded-Encrypted: i=1; AJvYcCW8AUxikXPQD7jmOtimD1b+AxQnjb0XNZpv35DRhzxQjxcR5lyhlXVlrmGHklMXd1YaABvmrIbZbvR5zns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUoX0rMPT94OZITKS1wjraKokqnKGogZnfao9dQqdxrws7F01m
	IFFYY6fuo9Pati31UEFWqDgFUtDC6ZseC7RIPFcgvZW8IZLLgn21nV4C
X-Gm-Gg: ASbGncuu9InDW/IN6wFUZ3nZhx5Fpk+bNvoDSqXF+2MmIvQIkco3rkzRsY+0e7+1rF8
	R7M/yxjSbPuLKS10cAIaSH3Q6Yi0772+TPcdG8yT8173r+6RpTm/CSBTKmV9gNQhWYz24IgDF3O
	fuO+/77RqkyLZjVfJrf1wuJWUIUEMUw336rbuUWxuHJd9AMnxzZi3nwEDUFtp9BAibvq45WYuQw
	JjGDLYQvcyml0/kgTWsPbb27mj5uht0tR0RpgJpK0L39nu5mqep5sIlNHCo+K2Qb9gWyiatDCph
	5w1gtDUPm7us+h8L2EFo2Sc83esEpXXBUMQ2/gONU9FP2L39Uzm5jSnNOPVLbuVX6WB4Hn1gkMe
	UoIdpY5b2IPd645k4RIWFbggTE5HQd8MCw79yhj6YuNwb0bWXtQES4sC4J2mYc+ysmQjnALPLU5
	SPK+sx+7ms4g+QatQmWw9Cnh5HBZlidWeYQDAICGoOX9+2uMme/iVFR03gOg==
X-Google-Smtp-Source: AGHT+IHJ74P6d7A+INVwA98f5iJflbVrWJao3lGug3xK3l6qx0+mauB/rdLhpcHFC1X7v1I1yEMgnw==
X-Received: by 2002:a17:90b:4a4b:b0:33b:b0d6:6bc2 with SMTP id 98e67ed59e1d1-3403a2f2219mr1197121a91.30.1761705148273;
        Tue, 28 Oct 2025 19:32:28 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.32.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:32:27 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 4/5] arm64: Provide arch_sync_dma_ batched helpers
Date: Wed, 29 Oct 2025 10:31:14 +0800
Message-Id: <20251029023115.22809-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

arch_sync_dma_for_device_batch_add() and arch_sync_dma_for_cpu_batch_add()
batch the DMA sync operations, and arch_sync_dma_batch_flush() waits for
their completion all together.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/mm/dma-mapping.c | 24 ++++++++++++++++++++++++
 include/linux/dma-map-ops.h |  8 ++++++++
 kernel/dma/Kconfig          |  3 +++
 4 files changed, 36 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6663ffd23f25..1ecf8a1c2458 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -112,6 +112,7 @@ config ARM64
 	select ARCH_SUPPORTS_SCHED_CLUSTER
 	select ARCH_SUPPORTS_SCHED_MC
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
+	select ARCH_WANT_BATCHED_DMA_SYNC
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index b2b5792b2caa..9ac1ddd1bb9c 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -31,6 +31,30 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	dcache_inval_poc(start, start + size);
 }
 
+void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
+			      enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+
+	dcache_clean_poc_nosync(start, start + size);
+}
+
+void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
+			   enum dma_data_direction dir)
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+
+	if (dir == DMA_TO_DEVICE)
+		return;
+
+	dcache_inval_poc_nosync(start, start + size);
+}
+
+void arch_sync_dma_batch_flush(void)
+{
+	dsb(sy);
+}
+
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	unsigned long start = (unsigned long)page_address(page);
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 10882d00cb17..8fcd0a9c1f39 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -367,6 +367,14 @@ static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+void arch_sync_dma_for_device_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+void arch_sync_dma_for_cpu_batch_add(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir);
+void arch_sync_dma_batch_flush(void);
+#endif
+
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 void arch_sync_dma_for_cpu_all(void);
 #else
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 31cfdb6b4bc3..2785099b2fa0 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -78,6 +78,9 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_WANT_BATCHED_DMA_SYNC
+	bool
+
 #
 # Select this option if the architecture assumes DMA devices are coherent
 # by default.
-- 
2.39.3 (Apple Git-146)


