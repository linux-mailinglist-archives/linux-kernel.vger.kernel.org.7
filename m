Return-Path: <linux-kernel+bounces-795323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F18B3F002
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2487163010
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7827C172;
	Mon,  1 Sep 2025 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hVucwSm7"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B451B279794
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759846; cv=none; b=aS4Ox6kvlD1oKKY8x7ylw7kWpbqU/cATk2KISYGV3HEVipZoFVdp83b4DvMEw5TGqu4yuCfYPelRxX0NJwfKgfWDwVsFe0O+KUgjs8otFftFPlCIpD91COITgD0tCVC1dABE9uvaLUDwGEmpSLWwO3iEbIyBHEXMHv5zc9WAx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759846; c=relaxed/simple;
	bh=Uiwj5FytXh8JuGFYDmzftQKcOe0iTru3tGLWkIpecec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2QxD/mG1EjV9S8KrmPzXRwSNQWnUQ0S9NVHFPqUaFfiaqsTIhtiWrxCOtuXIB9Hj3fpX97tKi0tHwc6uNzi6KK4qKr9+FXDKNUQ+iwf7ILaIdSgxb5HqdygBuX+qaRASSseU0hoHoG75JNv/ayA8M4Bkqd2f28t0Bm3biyS31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hVucwSm7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so697408066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759843; x=1757364643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xc7ijYojCT4luS7LR3VDEJwaByj8Czavl1FcpBrU7UU=;
        b=hVucwSm7pi8jhoXlcCNB4cUSsA2xoXsm4NPxGeBRQqDYhHmSUxmdy/KXjrJHHG8iUl
         AC+GzfT1dEL8hUKifuoOgP/1KE28PYlFhpgR/huCFs3NA/h57/soKgpmiWb2LpSbq8Kw
         k3itCb1lmCLeZmG9ktU953RHHM884rXBOIKB17RfEr6sqTmm9kpcXGJgVKS+PCQtig3W
         FT7/lcoOsa0tX7DQ2hWMpRX8X6ZInEiEyrp4wk9LvyUs2vvixlzJqBCfir6Bw2iYbTyz
         MBur2ZRhKqR1oLTbbJbU+IeORkF+v4+FYWxrTSFJTteRbdEhaXVmDQmxhmfN1eDKVGcz
         tMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759843; x=1757364643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc7ijYojCT4luS7LR3VDEJwaByj8Czavl1FcpBrU7UU=;
        b=bQ+kxdDuom4mij4hpdcBweNM+B+z40/PNpwqnjGBeLXSrld2GALqzcxLHfCqPvjshh
         Da1YftxO4o39HdowH1JHST5a8zbi83FbGzwEWuSrShCEJPxj3nCxmQ7vr40uUJdoriyC
         wESNG4IqcXBN1a8kupqYn4ZLss9h6CEI0p+c3DvLbHCvIAINJo11tg5ZemdQ4VaCVgMF
         sD957xQZhsPwyTiFdnu6GUVTamiAsbxBqz83gbNaJjKqr6muUSSSAZZGCdXH+mdD8Fgv
         uyfCJr6Q1UUDlUGTGDp5IjW/zQ/OdUcBI4f+GPD/11smdD88vjd1G4dEs/yDS7c0N5ga
         g22A==
X-Forwarded-Encrypted: i=1; AJvYcCWoNciZEqmfSihxnlnzABFgwjRo1ZnY3gwr3VJI3ct055FLpPhIMCHXU68NuLkxfu5QuA2E6qQsRQC2m64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJKjIlg/5xMgz6wfwYXazSGEKc80pHeBeEsry974rJ180ucol
	f1MAqWt1tPgS97hwtDIlzcGjN+mXAJPwA8nLk0S5fIcQKDGjEkWx3mENEmwmA67ZvJ4=
X-Gm-Gg: ASbGnctfzP1mjYlT2sbKASI7vLvVQ3ZqjTiQt4qOIMW7qcn0MQC3zAhMfFygtfzR3Vi
	mMOnLsBKr7MctqkhBQ6zumpp5UWxZ/aLx9MMv7GIrav0UdSeKeGbSHMvoNaz4DUqoF3AZ8QXaCT
	aSRXdbWlNeK+bhOIkLe//91tFBDB2Ri79HjDvcpT/bvjJWCVkVIfK7euyjtrqsS5QKcpvO/e1hp
	szkWBMbIQC+H1oEq4ADla9SNYcmsP3vI90MI21J/JMbanHy6FYW6u5aaqTgONSHq/SSyRuXz1Cu
	AeHZ0sdi7VCztECMCsk7/tLuGD0HiOMuD1T36DhlkiyRxuz4cZ0ROTpo0YqVra9RZz6gMvCswLy
	M8yec4aQVD/GSyLC0ATCP6v6lPwUZCDUzbl34dyfm7hhbk/KddSXpDL7dYIygxTXWn54zFZSnP7
	c16VhcAPbYHZTNdud52HXlJ28f67SJuDdH
X-Google-Smtp-Source: AGHT+IGzJPehXmI9EiALURY/rXkYz5IeFVzDP1ESKudUiTiCx5T7yEPplQz84NPBzI/8iDTakDOKMg==
X-Received: by 2002:a17:907:60d3:b0:ae0:b3be:f214 with SMTP id a640c23a62f3a-b01d8a267damr879923866b.9.1756759843094;
        Mon, 01 Sep 2025 13:50:43 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:42 -0700 (PDT)
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
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 08/12] mm: constify arch_pick_mmap_layout() for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:17 +0200
Message-ID: <20250901205021.3573313-9-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function only reads from the rlimit pointer (but writes to the
mm_struct pointer which is kept without `const`).

All callees are already const-ified or (internal functions) are being
constified by this patch.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/mmap.c              | 4 ++--
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 arch/x86/mm/mmap.c               | 6 +++---
 include/linux/sched/mm.h         | 4 ++--
 mm/util.c                        | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index e188cb6d4946..197c1d9497a7 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -47,7 +47,7 @@ static unsigned long mmap_base_legacy(unsigned long rnd)
 }
 
 static inline unsigned long mmap_base(unsigned long rnd,
-				      struct rlimit *rlim_stack)
+				      const struct rlimit *rlim_stack)
 {
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_maxrandom_size() + stack_guard_gap;
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
index 241d2eaf26ca..77462027ad24 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -431,7 +431,7 @@ static int mmap_is_legacy(const struct rlimit *rlim_stack)
 #define MIN_GAP		(SZ_128M)
 #define MAX_GAP		(STACK_TOP / 6 * 5)
 
-static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
+static unsigned long mmap_base(const unsigned long rnd, const struct rlimit *rlim_stack)
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


