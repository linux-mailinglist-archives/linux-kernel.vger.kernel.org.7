Return-Path: <linux-kernel+bounces-740549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C96FB0D595
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58157547BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9AE23ED6F;
	Tue, 22 Jul 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JCgNoXij"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DBE23AB96
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175727; cv=none; b=Y4UVtiL7Egjl0SAhtFRGg+Xwr4tfQ7zgsQ8Vdd6mlEa4EFFyIUR/Z2JqQqVeEtMF1QM41QD0Pp5pOkCvoP4xhjPsP6fea9khXLquI6hLptAH5DPF6xrhIuumHBdsMZHOqtlXqdSzytCjB8vANdV5CE/VO2XCNEZVo0+123LyuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175727; c=relaxed/simple;
	bh=2Y6zuF0N83/R8DsFiR6r67BBtZOoXRw/MV4+JLjKNSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Av1OndqRHGlpbr41GJuaO1BkFEFABaaEpesF0US7TJn3C24ZJGAdcmdBbcuf7eXh0BC09vqRmpiczL3gpnD111XPebRPa63XUI1v3h0q+eK4dYk3IXM3anuUTMoJ3bs9vKezpdanQ4dLk7kLkPikUBOLyXaLno4KSdOYK1p3ElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JCgNoXij; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748e378ba4fso6109565b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1753175724; x=1753780524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSJEZmkPgfnKjnqaAxlDxuBrFCv+rDIHtV6Q4YGYv1Q=;
        b=JCgNoXijC0ZA4HAQ7mi4YBx1fYJEA6cqu8IyKmCOxnNSgbFFerIbyX3IsGoHiM6ra0
         tBfgqU7ywsOfUNyVG1gyeFuTDZiNi7msEis1IJeUy5wlBk1FDT2qXrQETFjCUTBgKhXO
         1T8ujkZgWc3/RgaCfQmsh7yFdr9TJfL3y8UnGsGeNminVenLD+kF8H6nKQZhmIdHLkPr
         QKcNEhLiZ8uCmdfI6YEK+cIz2N+xEirCfyYz+dB5I8KFl7ounJ73i0gnPFWP6hYO0gem
         wZ6sob1WzMXU+V4cuxV+cXVak5yeVKfRTBku6trP7GnMPrPkgbWvs+CT/rjdRorA1HKZ
         Algw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175724; x=1753780524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSJEZmkPgfnKjnqaAxlDxuBrFCv+rDIHtV6Q4YGYv1Q=;
        b=e4WhI3yerQ+LSy+Vy5CcNmnPZP1BJHPSYWdYFdwVyoQiYGuTjIckLnirC9ODcY/kjW
         20ZtL28Xm5FBdcOlnHkMrnaEq5QEIRe1qeEmL2/KJGGGxOEJLRHfDme+ahHuZqWm57R7
         X5wC4J7j4hbb2v6qMExfSGjCmMLPq7bzrYQbdGLpo45ULfy3a1wItDHJA0U5+c+CT5S/
         UAlBBdAK6rz7pdl5edhmRpoE2AmRupNXUbEdfua2JZdb1OK4ydKLHe/FaQvWdYa2Idx3
         CrlzqCRp6L2Mv8+wAREjAmJdyFN1W++j1Q0dIJuZDH4tYD6r3CHcVWvAGopq2Rv9pXo2
         z5SA==
X-Forwarded-Encrypted: i=1; AJvYcCXSd0gmYZ5Ctg91KJYlrw7LP41C7PAJhhNh6MS4ZiwLvBmfrZPhPxTk9zpjb6WolOzSGzkOZ21zePl6QgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWJFfQ5VVsH23W56Tm45OdokY0u5v4jxY/6PkQ6mVyLxLW8oS
	vXEuSoKbKvogu8hjbDGyL8o9WUcg48/KvKLE67fLxxemPoO4Wy9f1USbtZib0m8PMfU=
X-Gm-Gg: ASbGncvRCbxMwPPYoAWRQPM5dwSLNCGs1tJpoSKflkKbY/R6s0vkcud0dpMtUsF8bc/
	e9IKy1UPy/2rjNtFgG03CmrbJ1FU/mBQAqZ7e9/eUCLVURmQaHCOrOruhcYhHlgfGJAL7YUfkIv
	9j4C6qcVDM0rJ6V4LYoUjfnFRw2KfcVx2+194VqKgKt8cmC78rUgnhZ5mSNbYNbfWuFyIxA7/5o
	xjuD3yTbrzGhfc6k1legkzAYx+rU/nlw4uOZaFRjbREZacnWhd7E2E66jULk63lmyuATiTcfNYq
	FpyNG/rKs4T9Gq9aWsUYJGjsrnRcO8xJXqYrvJgdmN/+1qTIXT7/GopLyNb1sx4cGkUUF3Z6bvr
	wW5CS3wVhjj7wyynHrMa8jNc0XDWoxUrkucrVBLqJGOhR1IQmX5nekpE8
X-Google-Smtp-Source: AGHT+IE8nn7g0sfttFkjFPlktCQQfoskYiWx8F7P7RBaYgJMDYxpTs0UIiig0ZzTsouqdeR9MRSjXw==
X-Received: by 2002:a05:6a00:bd93:b0:751:6ff5:df35 with SMTP id d2e1a72fcca58-758492e7360mr31464955b3a.8.1753175724338;
        Tue, 22 Jul 2025 02:15:24 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2008sm6676900b3a.30.2025.07.22.02.15.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Jul 2025 02:15:24 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	anshuman.khandual@arm.com,
	kas@kernel.org,
	ryan.roberts@arm.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	namcao@linutronix.de,
	willy@infradead.org,
	abrestic@rivosinc.com,
	yongxuan.wang@sifive.com,
	apopple@nvidia.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Qingfang Deng <qingfang.deng@siflower.com.cn>
Subject: [PATCH 1/1] riscv: introduce ioremap_wc()
Date: Tue, 22 Jul 2025 17:15:04 +0800
Message-Id: <20250722091504.45974-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250722091504.45974-1-cuiyunhui@bytedance.com>
References: <20250722091504.45974-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared with IO attributes, NC attributes can improve performance,
specifically in these aspects: Relaxed Order, Gathering, Supports Read
Speculation, Supports Unaligned Access.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Signed-off-by: Qingfang Deng <qingfang.deng@siflower.com.cn>
---
 arch/riscv/include/asm/io.h      | 4 ++++
 arch/riscv/include/asm/pgtable.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index a0e51840b9db4..09bb5f57a9d34 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -28,6 +28,10 @@
 #ifdef CONFIG_MMU
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
+
+#define ioremap_wc(addr, size)	\
+	ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL_NC))
+
 #endif /* CONFIG_MMU */
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 91697fbf1f901..3d17399a06c77 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -203,6 +203,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
+#define _PAGE_KERNEL_NC ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_NOCACHE)
 #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
 #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
-- 
2.39.5


