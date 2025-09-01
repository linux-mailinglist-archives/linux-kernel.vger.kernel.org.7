Return-Path: <linux-kernel+bounces-793882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8060AB3D99C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459DF17A12C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF02260563;
	Mon,  1 Sep 2025 06:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PCw+SFeS"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E6258EE2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707163; cv=none; b=u7WDXrR7nTxlEd6gaGSz24GSwSOqbaoyXDMLzl/I3eOmw3kpZUj9jlF23ZLj3RlBLai/b+N/M0I46EAze83IQq5SadbUg1q502WwAnys4U54QdSUWf1jgrGVinxa0QfZaaPpae3/ZP/uZxMX+BkGZd/yuL/w3D8GD5uYC33Mxps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707163; c=relaxed/simple;
	bh=YGg2hnsYALJcKhfmF9NNCR8/aARyJJjSXN/qFpjUbTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaQ5MB7nFHo1ZcG1FwUmm+Du1Tmsraepm8ti4lzsZw8znN2561IFP5xUfEfAUhBznX7zktjb06nuC/MvyTjUKLKKDcb53X7NXdF/LHgFbocDU8Xw97LS92duBATN0wH7YYMH8VUS1WilKKUv+QVKY4TPi2dGhGFEarTteHQfaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PCw+SFeS; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61e8fe26614so1503084a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707160; x=1757311960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMV7fZLCTw91Ub0dFNNIHemoRG98amxSAwmTMmAcs0c=;
        b=PCw+SFeSMW95dnDyceAgYc7xFMmBrFmc3ERBpoEF/Kw70JpGzpu3/nfD9LbaMZKoM2
         UVqBXXOm7qZ7s2jKb5uwuiw7NxpG/KlCy6/qo8Z3dJxnlgI2WYhyOXiLa8XsA5X822Wg
         WCBMpMmUjItW/9lAvMAvXdLB14fyrB8Sv77brXDc/UHPddxAkWOCd8+Xl2el2vYDkwdp
         yrULJYQDJTLeSt/NOrXhNYR19d7/5Uyqj8H9vUzXpqtLyY6xZhhACRY5i/JcgB/6DJvx
         S7wbfR3ucp9i+gZ6J0KxgGjZRuf04Z4ThxVq/6btIjkLk0i7a6ZrSCKBic8Om2+HEEy5
         xCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707160; x=1757311960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMV7fZLCTw91Ub0dFNNIHemoRG98amxSAwmTMmAcs0c=;
        b=a2cOGAuHauya8Y9VGgwnbR5P8uxzglnSrWNOqd7Z95Gq3ciAbBJL6/LfXuDwQg6xI8
         nynoj51iXn5rFzgmJZCcAK04G9DCrVtTEBOuGN4tAgRFg+B73E21xca5QOUHfHm9u9OJ
         RkrkZR2fEJGCXZcbYi12TfHdHXFQmib68DZ/uTGvwx2ZXgF6epeQ86JLus7+5hlh43qs
         cK3mppivgbg8H196pnrhokMdsNP4XUaUuYaPFDTMra/ytDCMbgAv14gS4LotMCUU/j0b
         z6yVcENwPbaLKQU6IB/xITQKoFIGUOUt3aJa3Bbiicfu8B/LrX86jkLWvvwPoVAB2HpG
         nUEg==
X-Forwarded-Encrypted: i=1; AJvYcCU2lnFCpaM3rrrTVDSS+X27jTxk/x0PaThVT2R6XIDFMd0ZiYJdmSPXT+4ZYdzyEZTIom5dZh1KCp50pzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfkOJ0igXJgCMS1IX3hjOdgcpARu2EwDmVfrZbdWqLuMVyUUUx
	fM+9CFEEQM1Z75Rkn3hr5jePPxMqm+oFeZ4+MW6BcRg2Td+un21v+LTGvoj9rH85XtQ=
X-Gm-Gg: ASbGncu9zyITit+6GwTLaVaIOp8Tm3rgJ4Ui0fJqkMBwII7Q/hD7hFl7hLCP198nWct
	DRzJPMiBegO2bL26xQ49lVvrb8ot5uWeyRcnNmdwZRWXIBjtgq7Xvi2im6+fqfEsmOOW1Ixk5CX
	Vdss5+ZoaZl7kj+mPgDKfoB0kETi4Pb7y1fQn57mqsRfMjfRfpY9VxU28X20gh+SyhmqIVPzSeC
	mWAZKEhwDqErAOFlkLOukEmcQ1JggeY0WrhFQHy/sZS28QTtm/ze2eieuJGAmghjzsvy8z5C4Em
	TfTyRUOb7kotZHGU+DG5QPQFEXbjqiyJDv2aGboL/7tXmc3eENmg7Yc4jbevSjtydYYzFpaSWVE
	xdRuFpH0S5vR1WiL+ZulhjGxWXo/2tpkXGnI6s1HQPSRXCkyJfzappFQEPhgMhjTrplyTjCKKQH
	2f+811FLhNKpierA7ws62ilQ==
X-Google-Smtp-Source: AGHT+IE61/JzTZaY6T03P50LVJL6zTCqVRZn14C1mT9luFPyfmIAshvEk3NBGAkYGLzTsD9oi5e6pg==
X-Received: by 2002:a05:6402:2351:b0:61d:2096:1e92 with SMTP id 4fb4d7f45d1cf-61d269882d3mr6111842a12.15.1756707160010;
        Sun, 31 Aug 2025 23:12:40 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:39 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 08/12] mm/util, s390, sparc, x86: add const to arch_pick_mmap_layout() parameter
Date: Mon,  1 Sep 2025 08:12:19 +0200
Message-ID: <20250901061223.2939097-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/mmap.c              | 5 +++--
 arch/sparc/kernel/sys_sparc_64.c | 3 ++-
 arch/x86/mm/mmap.c               | 7 ++++---
 include/linux/sched/mm.h         | 4 ++--
 mm/util.c                        | 9 ++++++---
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index c0f619fb9ab3..a47c7133d82a 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -47,7 +47,7 @@ static unsigned long mmap_base_legacy(unsigned long rnd)
 }
 
 static inline unsigned long mmap_base(unsigned long rnd,
-				      struct rlimit *rlim_stack)
+				      const struct rlimit *const rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size() + stack_guard_gap;
@@ -169,7 +169,8 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
  */
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	unsigned long random_factor = 0UL;
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 785e9909340f..1c243bb461b2 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -294,7 +294,8 @@ static unsigned long mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	unsigned long random_factor = mmap_rnd();
 	unsigned long gap;
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index 708f85dc9380..13bde4ba2f24 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -80,7 +80,7 @@ unsigned long arch_mmap_rnd(void)
 }
 
 static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
-			       struct rlimit *rlim_stack)
+			       const struct rlimit *const rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
@@ -110,7 +110,7 @@ static unsigned long mmap_legacy_base(unsigned long rnd,
  */
 static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		unsigned long random_factor, unsigned long task_size,
-		struct rlimit *rlim_stack)
+		const struct rlimit *const rlim_stack)
 {
 	*legacy_base = mmap_legacy_base(random_factor, task_size);
 	if (mmap_is_legacy())
@@ -119,7 +119,8 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		*base = mmap_base(random_factor, task_size, rlim_stack);
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	if (mmap_is_legacy())
 		mm_flags_clear(MMF_TOPDOWN, mm);
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2201da0afecc..0232d983b715 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -178,7 +178,7 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
 #endif
 
 extern void arch_pick_mmap_layout(struct mm_struct *mm,
-				  struct rlimit *rlim_stack);
+				  const struct rlimit *rlim_stack);
 
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
@@ -211,7 +211,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 				  unsigned long flags, vm_flags_t vm_flags);
 #else
 static inline void arch_pick_mmap_layout(struct mm_struct *mm,
-					 struct rlimit *rlim_stack) {}
+					 const struct rlimit *rlim_stack) {}
 #endif
 
 static inline bool in_vfork(struct task_struct *tsk)
diff --git a/mm/util.c b/mm/util.c
index f5a35efba7bf..24f08217cd95 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -431,7 +431,8 @@ static int mmap_is_legacy(const struct rlimit *const rlim_stack)
 #define MIN_GAP		(SZ_128M)
 #define MAX_GAP		(STACK_TOP / 6 * 5)
 
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+static unsigned long mmap_base(const unsigned long rnd,
+			       const struct rlimit *const rlim_stack)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	/*
@@ -462,7 +463,8 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 #endif
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	unsigned long random_factor = 0UL;
 
@@ -478,7 +480,8 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	}
 }
 #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *const mm,
+			   const struct rlimit *const rlim_stack)
 {
 	mm->mmap_base = TASK_UNMAPPED_BASE;
 	mm_flags_clear(MMF_TOPDOWN, mm);
-- 
2.47.2


