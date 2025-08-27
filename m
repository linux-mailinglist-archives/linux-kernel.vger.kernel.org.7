Return-Path: <linux-kernel+bounces-788379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B787BB38389
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5CB56867E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64553352FFA;
	Wed, 27 Aug 2025 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jILYzWPq"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4B2F1FF9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300504; cv=none; b=aCZM+YuJK6jPbc21rJjl4DNmME2oem4dOxmS1nzTmUfmayjvUhh+vcxZXC+5gxjwlDpBPzPvKSmbDu2HVBkx8mY1ubMElpLdzC8Vlqq2GzUqDgMwhV6cgUmgfYtU4stELm2WXahgL9QyYS3664YxgnHkWpbu+VmQc7Tg+Yewq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300504; c=relaxed/simple;
	bh=+sZ77WjHTHt90fhAq699UVhWKshOd6ZBE82anXZEMFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpImjsJ/7xnOKg+aC1FW0CLAL8Xj4Vr9Pedt8RmPEIBVhoAwUPoxKfdkGcwLe7S0Euj0VdmCe+xpBW9j/3LhOG3QoldGGbeiE17D3IGY1JgUFIFZ59zWT716dT+FkFlRU5jn+P5BV02tWw8T6C9tBeskqlAFVj+5lG7xG6jmQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jILYzWPq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-770593ba164so3134762b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756300500; x=1756905300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yoam2Ed8JJCs5sRbaWgfuw9sP/krLyryxA9VsbblUg=;
        b=jILYzWPqh9mebIBbgS7qVoaACsH9rNBz4OY/1tGlJURf/rgxZbvoDmTFbPuTSFEqe6
         aqmYjW7aqtI0qR23SpyO5NFlAUUYysoj17bcIwLTr8gcqih1oimDBR/jmxgqnhkiHHvf
         RDnfb93Og+DOZlbZDXzejK+R7Gxxql1/HL4X8tXfjy/QLhHS0UCsH838g+0tU+pPY3sy
         S+uXQ0/bTJc7gVlQXKRb1NvTrNnu/N4PAJWlaHKei1I/K9FkzOlCLwRjklV9sbC5m2Pi
         xNldwHO6rIx6ooqT7Dc/6WH/sVoe232qBSM5JE4XrLaerhn3cXj0z05z6laZDOwxmDtA
         oGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300500; x=1756905300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yoam2Ed8JJCs5sRbaWgfuw9sP/krLyryxA9VsbblUg=;
        b=WxJJVTaftxh2b0CGKjhbJ6Ad9xWayiLx67h5Fe9CGxX/aQ8yiPiw3sTVHs29b5chjW
         UWlbdUjlN9j6BS3e13mRLKsXRhU0cVSWT6glJ53GCuI6vdmxYQJdnqHDl16FYF3Gogsf
         blrx0EYWbo6OOFL4PS9t+zWMjFVT1W/oRDKRgFf5DAkNt7++8ZZMexphcGpj+DqGMBBN
         Ep7yEktcYTw2r2zb4LjF/ENRcBa6DJbKc2SMZvQfUrY4BRTEwKv58uv69ePShMf4YfCc
         sZ1BEPNDxPWmRT2CUGT4+VCdDZjkcmRbJd9c8+Cw5D4lZy6KbvQbMKLh4nWrBjYUbaqm
         zTzA==
X-Forwarded-Encrypted: i=1; AJvYcCXz93BIP5ykq3yD01SMvYhcy2azn58nSADLzp1VL57kMEyzKch8efYcI9toM1oFur/VRZdjw8P/mGk2C3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwePWh+xW+eONA/a3lJuNWPW+oCa2yYSQC0WAQijM9iS5ABi+6E
	uKckQZtOW604ktJlBVGaiyLIue8IjL8IyVfPTqqisP9cFIRbEtHDX7OzID3PCmzO8nE=
X-Gm-Gg: ASbGncv9/XfRGu6ijYZ/ZhxGdg0a+oK0lEHe+Z5SWa0Kch8EXAx6OOURXd1IaxVQzgM
	f0cb9DzFTKUmD+jGMcZBHDq/BzY8WW/DQohKXJIApRQaahBeuy0j9EyjnWvr9U8LiwTtoeFqLjK
	suvSHEngjw2h+yMQUA8Zf3iOtDZ2pdoD5zP7x9j05D1ZLkfIFuH2xBCS5TKER133IEXoUp8Fjuv
	xWJbwe7qEm1c/qLGT76TLPeef+0aX9voq8nQ72gKnXApGXjYG7xpWwfp0u3lXk11kg31GrlypQP
	yWD1lOidpMdLKCtbBow2xsrpzQfJekcoLdXCCR8NlroqUchsRKW4Lf6nUt1BxshJF/Hv6nFtF/i
	S9LME5WHqFs6PZWTQhXy/VdhgQ4ZUdbWZ0cDLZF9P5pOyS9roNICg+NUhYQswhoxZP1S8CYo8Ni
	MW0sbtXSUOlYo9VfLJ3laJ7Yv+5e/1qisjvg1vyVvV6+E=
X-Google-Smtp-Source: AGHT+IH093oiMDk1IJe8n5AdJKx3X2MU1Aan+sgd1rlVBn2icqsAZZ2z8qfKLqFhQrakcrMJ0Xp7uA==
X-Received: by 2002:a05:6a00:1893:b0:770:581e:55e8 with SMTP id d2e1a72fcca58-770581e5763mr15686407b3a.27.1756300499864;
        Wed, 27 Aug 2025 06:14:59 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772017f538esm3172443b3a.21.2025.08.27.06.14.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 06:14:59 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 2/2] riscv: mm: Clear cpu in mm_cpumask after local_flush_tlb_all_asid
Date: Wed, 27 Aug 2025 21:14:44 +0800
Message-Id: <20250827131444.23893-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250827131444.23893-1-luxu.kernel@bytedance.com>
References: <20250827131444.23893-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear corresponding bit of current cpu in mm_cpumask after executing
local_flush_tlb_all_asid().

This reduces the number of IPI due to tlb flush:

* ltp - mmapstress01
Before: ~98k
After: 268

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/mm/tlbflush.c | 41 ++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 962db300a1665..571358f385879 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -17,7 +17,8 @@
  */
 unsigned long tlb_flush_all_threshold __read_mostly = 64;
 
-static void local_flush_tlb_range_threshold_asid(unsigned long start,
+static void local_flush_tlb_range_threshold_asid(struct mm_struct *mm,
+						 unsigned long start,
 						 unsigned long size,
 						 unsigned long stride,
 						 unsigned long asid)
@@ -27,6 +28,8 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
 
 	if (nr_ptes_in_range > tlb_flush_all_threshold) {
 		local_flush_tlb_all_asid(asid);
+		if (mm && mm != current->active_mm)
+			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
 		return;
 	}
 
@@ -46,21 +49,28 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
 	}
 }
 
-static inline void local_flush_tlb_range_asid(unsigned long start,
-		unsigned long size, unsigned long stride, unsigned long asid)
+static inline void local_flush_tlb_range_mm(struct mm_struct *mm,
+					    unsigned long start,
+					    unsigned long size,
+					    unsigned long stride)
 {
-	if (size <= stride)
+	unsigned long asid = get_mm_asid(mm);
+
+	if (size <= stride) {
 		local_flush_tlb_page_asid(start, asid);
-	else if (size == FLUSH_TLB_MAX_SIZE)
+	} else if (size == FLUSH_TLB_MAX_SIZE) {
 		local_flush_tlb_all_asid(asid);
-	else
-		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
+		if (mm && mm != current->active_mm)
+			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
+	} else {
+		local_flush_tlb_range_threshold_asid(mm, start, size, stride, asid);
+	}
 }
 
 /* Flush a range of kernel pages without broadcasting */
 void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
+	local_flush_tlb_range_mm(NULL, start, end - start, PAGE_SIZE);
 }
 
 static void __ipi_flush_tlb_all(void *info)
@@ -79,17 +89,17 @@ void flush_tlb_all(void)
 }
 
 struct flush_tlb_range_data {
-	unsigned long asid;
+	struct mm_struct *mm;
 	unsigned long start;
 	unsigned long size;
 	unsigned long stride;
 };
 
-static void __ipi_flush_tlb_range_asid(void *info)
+static void __ipi_flush_tlb_range_mm(void *info)
 {
 	struct flush_tlb_range_data *d = info;
 
-	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
+	local_flush_tlb_range_mm(d->mm, d->start, d->size, d->stride);
 }
 
 static void __flush_tlb_range(struct mm_struct *mm,
@@ -97,7 +107,6 @@ static void __flush_tlb_range(struct mm_struct *mm,
 			      unsigned long start, unsigned long size,
 			      unsigned long stride)
 {
-	unsigned long asid = get_mm_asid(mm);
 	unsigned int cpu;
 
 	if (cpumask_empty(cmask))
@@ -107,17 +116,17 @@ static void __flush_tlb_range(struct mm_struct *mm,
 
 	/* Check if the TLB flush needs to be sent to other CPUs. */
 	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
-		local_flush_tlb_range_asid(start, size, stride, asid);
+		local_flush_tlb_range_mm(mm, start, size, stride);
 	} else if (riscv_use_sbi_for_rfence()) {
-		sbi_remote_sfence_vma_asid(cmask, start, size, asid);
+		sbi_remote_sfence_vma_asid(cmask, start, size, get_mm_asid(mm));
 	} else {
 		struct flush_tlb_range_data ftd;
 
-		ftd.asid = asid;
+		ftd.mm = mm;
 		ftd.start = start;
 		ftd.size = size;
 		ftd.stride = stride;
-		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
+		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_mm, &ftd, 1);
 	}
 
 	put_cpu();
-- 
2.20.1


