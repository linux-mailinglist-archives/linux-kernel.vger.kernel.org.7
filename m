Return-Path: <linux-kernel+bounces-793302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF9B3D1AC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0072A44311B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30925A324;
	Sun, 31 Aug 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SCY74Vgl"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A6225791
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633187; cv=none; b=djLWooYgk8bmCS6HsTlk1d/eFW4M3k05Rpm8WXOBE0qZtXznyfMIDjMSrsn3QRzr/ZffEWLEc6fA4vXxr6NVRcNlL1tlMOwUu2WMeT2YdjuW9BP9Jm7FiESxTBaAu2Q9RkmC2X9SMsIF3WabFzLdx/2SiIi/gUnktcXGdRHurxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633187; c=relaxed/simple;
	bh=VdT9jGWeY6TchzE+H8HBCcwUE7G/YUGT3G0aAk2KDdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJNW2R2K1EQEquNbctnIzk/7RzlZA9HCDWeExyjeddBLmzR2DWinnf0z8SzCYkL01LwIHtPTNRCcVtdt3HGRShVK/ZENtah81MJzujw8y5o9jpivikTlceCUDYInKaHAHVBuKwaUP9JO7GPmpws95QMzyoP+iduP9WlUh/l6oDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SCY74Vgl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afee6037847so520756266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633183; x=1757237983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwlx2EVOW3/w81+M3sGLOhoJXHsbq6RkIxTDAR9OjUU=;
        b=SCY74Vgl+D1/p7DkdxLXkp6tIMBDePFJeFxGl1DKILycSEqzbwyGvT13/1snjnGbk0
         S70tGns+q2k4mN+EsgyO2ip6IniTujEMs6Bfu7d10YXS0y1I/s3o8lORjXzFVcpWtQVg
         1atSQLHqHAt2zvK0TkSincAs+dyapReyREv8WR+pYj0+XPkv1+SArMEKgLBhkwK5blsk
         FU3LiQcR2rIbOFVroExJ4eGoWCvRjYVxk5xUlsNzI6jqFO/8U1Tivv4j8Uyk9eJSTw6c
         1EH/EzKo1KiOw1zzw0L12XiDOmYV/r0c/Vj866jhEKWIF2cpsyGBP9pSYLXpnVllOq6l
         ++Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633183; x=1757237983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwlx2EVOW3/w81+M3sGLOhoJXHsbq6RkIxTDAR9OjUU=;
        b=PUEZlKUIzTpzwNzOLCYpJcJndzmnR7nKuOibIY9X7NGiotLu0t8MJqdMFIS40RrP5Q
         2d1nJV4Ov++ANxjBlfyFJQaO3aTMBwNvR2E8abs+MklIvLCfEQRdTshjQwemVEId+3DN
         WA5nfqX86Q3ZfWNGlwr2ReF6fqR++YMTQFygNyMUsFdBYF/VVc4DPVVyshNyUIvlIV90
         cg6l3VwfoivJUZz2qLzBWjWOMplGPR6d0bABkbMKucXjUM3oEdxKeXmpbj4DukBW9bWy
         qCAXhixBHxJD3D38c2dW0/8TtwdX42OTrqctNW8qnK8MToJkzvrHh/qX78XCnfxzIzDN
         /ltw==
X-Forwarded-Encrypted: i=1; AJvYcCXYxJLZ/aCq7obbQr5swmmSii+qPH2a3v5woAeclGrUFz0vVVV3+3IJdMOSUmyZMFTDiarcNkiUQNWSPEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7cdROeeeER6WBaIZ1cPa91vzRX0yNTdVTb7CxugP7pD0pRqa4
	oPBFXrn/DWSHOSL7VxeJIyl8sse3SFj0LaaA2ncJfa0l2P9JPgsLShDId+fF8GV0v2k=
X-Gm-Gg: ASbGncu+xQesyhVLLvX7SWF0aKHrNYKXedsJLEN9aIX/M77Ces/Q1F9USXU3T3CnaWM
	UqKVOeEKOK+0K0eo3QIXEbsY5PLczSqHNSRxkwPol/JGeDBfuF/Z9sXiKGN73MPt2CFBfYfagay
	qalxcTT8IEUIUT4T6VgSqq53FIW2sYd34HZS7nm735xljLCmQUTozjcvojPlzaoJeTL/8hadL7r
	NOTTEa+mTGqSuLIvsLeH/+4iHWvrOPLpwwKYPkYFbVmS8fVR2VU4dTQEVQ7l2f9uwYvrDWG5tM/
	VeajaBoOdbg/AMkcMueBONwbzvGXwkmSZk+aCb1FPkQk7Rc4noM3y/obehGEX4+rniQy3wrrx7Q
	uXjgtfpiL4QEKzlhP9TRJ4vjKMWigovQfbn90XYm3NrXnOxeZsuQqAH98dKdz5VAN59RpvWnByw
	3YMpuH7QhMKFeFRcwveVatXQ==
X-Google-Smtp-Source: AGHT+IHHEsy3VYapgP6t68znKr4JYYpwjepZ2OnahYHw25+r/10lb4UhzW3CEgWSDi98yrsXnMghDg==
X-Received: by 2002:a17:906:eec3:b0:afd:c31c:2488 with SMTP id a640c23a62f3a-b01d97307b1mr425157266b.39.1756633183190;
        Sun, 31 Aug 2025 02:39:43 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:42 -0700 (PDT)
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
Subject: [PATCH v2 08/12] arch, mm/util: add const to arch_pick_mmap_layout() parameter
Date: Sun, 31 Aug 2025 11:39:14 +0200
Message-ID: <20250831093918.2815332-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
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
 arch/sparc/kernel/sys_sparc_64.c | 5 +++--
 arch/x86/mm/mmap.c               | 7 ++++---
 include/linux/sched/mm.h         | 4 ++--
 mm/util.c                        | 9 ++++++---
 5 files changed, 18 insertions(+), 12 deletions(-)

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
index 785e9909340f..e3f0d9b74b00 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+ickj// SPDX-License-Identifier: GPL-2.0
 /* linux/arch/sparc64/kernel/sys_sparc.c
  *
  * This file contains various random system calls that
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


