Return-Path: <linux-kernel+bounces-792303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD585B3C27E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0D15A12DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812F350D65;
	Fri, 29 Aug 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XnBWG+5E"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922834DCC0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492339; cv=none; b=Z3jLcU5USgWON7dN/2bIW63MHJm7dBACh6G+lkor3TAfwyRmXWMs7YZ2BypJkjfv+lottOSqNL1zgz9luL9MzkrQ5i8r6g60f9Evvp7u1D5N7HOkiaZaLV7VpraZD0/C2aPkaZU2RhWvzpf0Xfgz1gUWrpaUE4u2IXalrA/znY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492339; c=relaxed/simple;
	bh=Zs7sHB3GTtCxwgvgJvepvykYyV8HmXxi9TX4OFjcRjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJxE62Z1p/0Q3Vd73rLmPxu/lNp2IZqdHtsxBS5GbWaSprfvmfmyPJyU7GpKeqbWOEkXULBrUM0jFvaRhCfSI7RvVZorfkdDkWl26RpU0iLflPoTDegI/M1hIckXoffSGJqCEkoMHjAHOxvvgBS2j2cyxJpxZtYel9bd3vt14XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XnBWG+5E; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ace3baso412787066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492334; x=1757097134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZ7PnN3wq5wKP2KT/uKeKbuD4jQQEwrG/IUaCtApCAs=;
        b=XnBWG+5E5GILlXw+xZuTsOX+HraFrngeWwWMTxlft467a59DZgP8A1Cbz9VsNSi0lQ
         cOBoyCJ2LO459xG/lc7LgE2cGNGd//rTf/HJuOBAJ0fbbJ3TZHjMBND9XfbRQxLvc3VE
         9sSvfKRmVM6PIEQu3OqJwXnE5LOjXAFFsTU4pkZLNyLwMWGUPJfyuevLXdXK2XsOFO+9
         FW/EI3fR1F9Si6B9HYaux5ZEcauEmVpClWNPWdPgH8Lmbfl/n/ATazfGaSU6buxqTFvR
         2gKc/BDal/eHForJO+isPcNrXZA5h/HwrC9oK6kfCtRTZ3fKHEDhvM5CHtNiu8sdWek9
         RWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492334; x=1757097134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZ7PnN3wq5wKP2KT/uKeKbuD4jQQEwrG/IUaCtApCAs=;
        b=K6vU6arwdsOgzMGgaZxvZpfR7qMLQ3CHVCmoJ9bO+C//PE55dqxLl6ZVJqenMP8K4p
         pFo7ibf6ZpckQRiywUe6tn1rBwwvyPPuJCJMMLqcd1m+7n3UN8cF0R9iXBLEljBqfJZt
         j5wG7oxGNr/2pfUfnrtiIneC2qQo6Pyxv92OJ8Gd6bik9uSTMag19kJJ+HHJYA0YWEXN
         WMHJ3LiOp8vECBZZY6z6f995k7wMeeiQ0ogi37vIWA2QRSOmNzwN2dyeJTQjZf/d7h/5
         Fe7F6l/mqflBseGADmOU2Zx88B1sDfa8kbmsKQD2vm3X8VQy7Raa/tiwxcnJkB5PtnPs
         K7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIPohns0fI70M4nusc7/pzNWy3qbQgyc44RAJCXs/S2rSjixLpjmMTRJkRAMtrNTFoCkZPJJ4X+GBT7HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzxG+7bcOYf5PQrjidYynbWjzGFaPPZypWemxUQGbnKEXxNMu
	lAkoBQq+Ij9zJB94KpsbDL2cwK6qFyBZR6kGEnmjRd9HKPsQCd+hwzpYYylauN6MOww=
X-Gm-Gg: ASbGncuJ4IOCtFbGjfgMuf9q1v9QA7xP1vf2O0yLg27VCLtJygcQ6V3LUKgSixFE5zk
	bG5B4KS+yBcxhMpq8bYZ4tE46PN5li5Vvu7z11HIz4S9MEFLaKgTyrFDSJTigx6iIUOT90ysbIe
	B1Pn2eApBw0/AKerw6xb0fwgrs1Mq9yx5tEBSMnz0IHER8eJPHTGAB6VYovifNsbOLIsSO3C5wY
	Id2TwrXBBUzHYzYeAfyEoB4AgtQTxY9GtEfvJm0MIitXxw3p5TkXZ7yvYWhAWpQPjv1VVjJp+PG
	OpIxiNjf1XjFqQpVVbNUUjegClvYQyYaj7iTJMg+bsuXwKLZncl/ij8Pk++sR41pGyiGGW4piUh
	RtNauTZkdkY2fqeReTbu6myy2OvsyZkpOSrZ2Iej5+VSg3ClI7LGmvBEOJEPczQBym93ZVZKKr8
	bwEdlgkyWKVmWkJcaU0nva8tcWJ3dq0XTg
X-Google-Smtp-Source: AGHT+IHzJOTy2luKB32sVUhBKgOt2xF3771qGw0tmV3b7MRDICZMtNEq1NDAa3bFUq1AzPVA5KaLMg==
X-Received: by 2002:a17:906:2a07:b0:afe:844c:bdd9 with SMTP id a640c23a62f3a-afe844cc4e4mr1495547066b.11.1756492334350;
        Fri, 29 Aug 2025 11:32:14 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:13 -0700 (PDT)
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
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 08/12] arch, mm/util: add const to arch_pick_mmap_layout() parameter
Date: Fri, 29 Aug 2025 20:31:55 +0200
Message-ID: <20250829183159.2223948-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/s390/mm/mmap.c              | 4 ++--
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 arch/x86/mm/mmap.c               | 6 +++---
 include/linux/sched/mm.h         | 4 ++--
 mm/util.c                        | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 547104ccc22a..767c5c26f9a3 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -27,7 +27,7 @@ static unsigned long stack_maxrandom_size(void)
 	return STACK_RND_MASK << PAGE_SHIFT;
 }
 
-static inline int mmap_is_legacy(struct rlimit *rlim_stack)
+static inline int mmap_is_legacy(const struct rlimit *rlim_stack)
 {
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
@@ -169,7 +169,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
  * This function, called very early during the creation of a new
  * process VM image, sets up which VM layout function to use:
  */
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	unsigned long random_factor = 0UL;
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 785e9909340f..55faf2effa46 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -294,7 +294,7 @@ static unsigned long mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	unsigned long random_factor = mmap_rnd();
 	unsigned long gap;
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index 708f85dc9380..82f3a987f7cf 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -80,7 +80,7 @@ unsigned long arch_mmap_rnd(void)
 }
 
 static unsigned long mmap_base(unsigned long rnd, unsigned long task_size,
-			       struct rlimit *rlim_stack)
+			       const struct rlimit *rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size(task_size) + stack_guard_gap;
@@ -110,7 +110,7 @@ static unsigned long mmap_legacy_base(unsigned long rnd,
  */
 static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		unsigned long random_factor, unsigned long task_size,
-		struct rlimit *rlim_stack)
+		const struct rlimit *rlim_stack)
 {
 	*legacy_base = mmap_legacy_base(random_factor, task_size);
 	if (mmap_is_legacy())
@@ -119,7 +119,7 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 		*base = mmap_base(random_factor, task_size, rlim_stack);
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
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
index 241d2eaf26ca..38f8b9fa297c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -431,7 +431,7 @@ static int mmap_is_legacy(const struct rlimit *rlim_stack)
 #define MIN_GAP		(SZ_128M)
 #define MAX_GAP		(STACK_TOP / 6 * 5)
 
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+static unsigned long mmap_base(unsigned long rnd, const struct rlimit *rlim_stack)
 {
 #ifdef CONFIG_STACK_GROWSUP
 	/*
@@ -462,7 +462,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 #endif
 }
 
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	unsigned long random_factor = 0UL;
 
@@ -478,7 +478,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	}
 }
 #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
-void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
+void arch_pick_mmap_layout(struct mm_struct *mm, const struct rlimit *rlim_stack)
 {
 	mm->mmap_base = TASK_UNMAPPED_BASE;
 	mm_flags_clear(MMF_TOPDOWN, mm);
-- 
2.47.2


