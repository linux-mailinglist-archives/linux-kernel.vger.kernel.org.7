Return-Path: <linux-kernel+bounces-794448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 039B6B3E1E4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57127AFF6D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A631A563;
	Mon,  1 Sep 2025 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SvLmONd6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3931DDBB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726920; cv=none; b=b0cPyqK3+ZzSaL3D03qo47esXHnV+zGy3xNBrcQHl8trJkhNJ8JlVeeKsLzeOaTI4Rea4FupX/9x5d2D37uebcS5oxaKQn/75xlt33HNBdaVAp0DzWNKR6mUTis9aaTSneWkgkwUbnSjmWQMaouNvwxr66KnlqZ645GD91+Th6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726920; c=relaxed/simple;
	bh=+sZ77WjHTHt90fhAq699UVhWKshOd6ZBE82anXZEMFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+W4wK7IvL3ASVgQNSl1leGDAuovy1MYEWhscP6ukvRO+Hc9ZddUQz5xHi6D39Z4wltXAHF7TgPV5ropwPXoYsvqd9lq8FyBVFlV+L36CKYcebe9UEYqIqntROxOnvNnwvgBVFTYPeYbxE0GAs7slwfP9pKom/EAgHbJ51t2+go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SvLmONd6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24a9ccbf10dso13094265ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756726918; x=1757331718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yoam2Ed8JJCs5sRbaWgfuw9sP/krLyryxA9VsbblUg=;
        b=SvLmONd69zoKLDfQmVjryTSWKUwz+OzRFtsSL7Kk93nm1meZuAsU8H8inplhF2gNcs
         KqQrk9zmi54hgSG+9pJllD1GewKOACe4ZdGtYP4jZ2CeYhD0xJyIWIXK18u7a1+kFTWp
         dZYLUiXMru5LoYPeqHEwfOs1ln2e690KYKd0Q7ro44NbTpeVxyS13ZIDlZ+LQzZwhmD8
         3TZANCcwoXifihJ8IlJAWLGCJDK6KVyJPn91N/nnkVUk7e2zvmmLkklystuvwBvaVZx4
         HZO0v84aHQeodIQw558mH4fGLfL+yAiDwKBQh9ptM2uIPu49PkPV3BAFaudRgSjvqXdj
         BMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726918; x=1757331718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yoam2Ed8JJCs5sRbaWgfuw9sP/krLyryxA9VsbblUg=;
        b=DkQmJ1mVW/PZds6eH/i5zOFMwRLOpj/LSuG0ilVACdfunVzuFA+6v6cVhHVYTQAJPf
         Rx7IemqeCceAp7TgvlW4cEyXMcoFtl4WyNotW9cSFDyNHeMqt/vLZ9CZzZREPRU/ab60
         JJnGXDI+9Wlto47+CIS+qPiu/X8iCZPbmsfNb9gE/SaGzX7ZmYrcw1bC5gGIqiHrX2zO
         SnU6awRIKSKbDl++OyGNf1F9bqSvPyhSiSCUfwc/VPlNMIoPCbV1rETnxVZkkSeDCK2H
         gEd4a5UN3RCcvdj/25NLlEhEJJ1gPXRgmwBX7SQgmO8elXyeqXdzjZwV5USPpY6jgO7l
         9p2A==
X-Forwarded-Encrypted: i=1; AJvYcCWlSDDz8jfAaNHeDNmUZh3k8m6FK6zynhgltooGc+bXyvipgFF3sPnsHtoYmU3Elimtr5EAidJ70vAuoAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoZ54bbHAEhmLTNCbdTUirNu6TDHKd7o13mX42ZSoMejZRm+I
	RveZZVJ435Pw1cYHxsc3AeWd5orOqZz10W6WHRDKWjB8MnduDsH7gwTE4hy8LfMJNIzWq3W3bqL
	f/LzFqIw=
X-Gm-Gg: ASbGncuEmKNJQnLOLfgaMezX2LYsykcgPgC7ADpwxS/EB3EDa1JK7/XY/jd9gIkgUfL
	lojfzIcKoaIpYDNpz5bva9LGNEVi71RkFoQznXbhIjdATLNifXLe+druR0e5085IhK9G4Qdfqki
	mBulijqG3bIflzbhLdAR0AkzG/CqBWR/zHFJ+EVCKq+tyPuWMzdKsgvmWB+cHNDfMxLk1jprKjB
	h9839K4vMC4BGz6OLRXAouuWS5A7Q9S+9m9EHDxRo3xYMfZjvmaKR5iAX4Gx1SohazDrRPXIhPP
	PzgCvWCj06CqDiOCxX+fDl4xe+RAu5FTeTS1zdbpo46yNiAGdNV0YettyTdYH/IMp5kSiaaS6Ld
	e/er8TR5mTBrBAqm1RUDL2BLC6mW6QxOB0eBguzed46ea56D3yAnT3qm/jreCqFwza/kLCTKmuD
	iyzpGUUDPcZC+gPKIkYboBEVOqvwZQEJQnC/08lbpiVVTJgdJInd1zSg==
X-Google-Smtp-Source: AGHT+IH9HacVdhhrlYWDJB9ao9Cj7vL+SYgn/KxsSVzOs5trPZW7TKzXPjSrbltXooT+Y+1VomhKUA==
X-Received: by 2002:a17:902:f64a:b0:24a:9475:3dcb with SMTP id d9443c01a7336-24a9475437cmr75175655ad.37.1756726917967;
        Mon, 01 Sep 2025 04:41:57 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249066e042asm103147055ad.146.2025.09.01.04.41.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 04:41:57 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH RESEND 2/2] riscv: mm: Clear cpu in mm_cpumask after local_flush_tlb_all_asid
Date: Mon,  1 Sep 2025 19:41:41 +0800
Message-Id: <20250901114141.5438-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250901114141.5438-1-luxu.kernel@bytedance.com>
References: <20250901114141.5438-1-luxu.kernel@bytedance.com>
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


