Return-Path: <linux-kernel+bounces-792300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07614B3C27C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F80A24F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F23F34AB06;
	Fri, 29 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NGwmFAsg"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54C345747
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492335; cv=none; b=OR0tX0SsiBBGybu1JeMQbciGVUwFPBPSActxsp2b1qGdL86binxMKI0VIRtAOVkKsS28ymbRdvsVNWmigHEL2+fk+TQefPYxBYbSrBgJrwwfpAkhnhM3VxpCQzBRRmaB0Mlu1N2kdrWyBg+nobQBqrz6cEyXDBVJFO+00pQNrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492335; c=relaxed/simple;
	bh=9avM9vCZBlHo6PrhD774Cxf55N0+lUeCJqpyJgi8Qis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbLao0Wmfe7txtmCKQ1Mh/chgCwxKzA+OZnjde2zUG5b5sTfwdeISvSOy7quwyNh1P1l5Q/pvvhEHYzzMLdCTQqTxR8OycmF1jNdpg1IcuMrzF11BhTZ9lDCaTRyezha+cV3ndLRSgWBQuxCpBw4P3x4ojgNStCK8T41Syvrghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NGwmFAsg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ace3baso412779166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492332; x=1757097132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8c+9yPhPtAEVLLT7PJHB5roc/KfxfndfYXWIZFh5s4U=;
        b=NGwmFAsglB3eWJ4kqK7zUyHfC6kcqv0fs4irBswbjZsl+a19uckRiaKT3Vr5QIdQir
         p5h9rv+ftDPBUV1rX+LqXKDB0CBDVJWsDKzKIiQsJ17bSxSfWgtH1J2P88iUL2KL/FjG
         /9RAOTWMxYL0r8iQe+9tobrr8/tjeFJQiKh7zg6uLQgnPY/LJsjDzQSwm+EUJNZaCF9S
         mjMPHISFCY9W4sHJ0qZMxNKK/KGdWgrhnAZzRD0j5S56e4wsT4rDQhwU/O4PWRkVc0i7
         rgMVQZFYXoQA7bOqxXLtZMpzXWy8npWdiRq24yAkOTyf3jZ8eUATOPQ+cQrhh0gk6bFo
         I2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492332; x=1757097132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8c+9yPhPtAEVLLT7PJHB5roc/KfxfndfYXWIZFh5s4U=;
        b=YYMNb09C1mog3ulW+P2uBVuVFBr/KDIUmW11XS0+md7kNUr9N0FPUx9wKcbh4CP1fh
         jdwiW+0IovBkpMIHGf0DMvsFiu13pTbD79EHsAww20GVZjk51wZvlw1Cm8exCk0JxDH/
         95qW7OglLwHC4GPzJUG2RgS1WhPyu0snfGmIZ+XCjz4QTuXpiwrOkd6ZhHQN9BsJcoIv
         vr3ew6M8YrHQTxljeF9m/zfsHlo69chPh30mN6du70sXgVhP3oWGri6W2TPvlCRdacBd
         TX/1TMip1ijtEkZXknCUPRFV1h/es73I3Edhll2Ov+Yo+EepNV5rd+uFeYv+8FC7wtde
         bFdw==
X-Forwarded-Encrypted: i=1; AJvYcCW7t+BEGTqZMm7Koc2ZAE+D9j69frrNSxG/+rUmp2tHi1fXMyIelL2qsEaU6MUC0O6zaFgy4+IdA2Ov/9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+g4uuSbkDaEC3S/A48L2ayp6sVNrs40JuTRK+0QCphEKDZWjM
	PK7uZz1OjZIzu/dRwbaS4ENyiOTbObZlZt9+6p2SwrmLJ9/GDbrFDuVCna/eXx7QBAI=
X-Gm-Gg: ASbGncufv5STtouU/YA8c0cvkipYy99PGHEMrWZjedKk2Tw+2TroMCJR58M0NCm/EPF
	LN1JNiyY7URJA9cEaBPqPYt/5gSb9uw7bRgx76TFzpagEo/n07rZMaxH9hMFYjmXUhnOhUVtp4P
	9k/tIZUSUnuoKzPGHAgu5YI4f6MWoog6w9Q+b8CQuvWBr3NrjSiD+9j/j6g/OoXuZb/2sIYXsGH
	QAGpxdC4RRO2ctLPwB/t/gABp3VuFtl4cvQQhNoCTZfy8YFOh2u36F/AX44RYbeuKxvl63JZeBG
	OLjFX9IV4MfLVrtEsnv+95YskdmuIdxtzythHvDNttCJQeRCu2aAssq+3lMzcWOARSDZ8CJuGBS
	0APle4YIaIUahiZ8qAcznEl6kr58ZZCFyPYXbE/ecW5R6XNm+PhiyUHIiaDXi2YvrpNtVdyGF+3
	8ZgvsEcZ13GBrhyDsTj8ONTdZqf/fYE2kgevc0tCTJQGo=
X-Google-Smtp-Source: AGHT+IETmvvQODdVSBHmZD0kjNnIecq6FKhW+BEE2rV4GPi6FJ1MCBfKCh+rA9cR4mQklNhUdrS8iA==
X-Received: by 2002:a17:907:3f9a:b0:afe:d21f:7af0 with SMTP id a640c23a62f3a-afed21f7e3cmr865901466b.14.1756492332358;
        Fri, 29 Aug 2025 11:32:12 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:11 -0700 (PDT)
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
Subject: [PATCH 06/12] mm/util: add `const` to several pointer parameters
Date: Fri, 29 Aug 2025 20:31:53 +0200
Message-ID: <20250829183159.2223948-7-max.kellermann@ionos.com>
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
 include/linux/mm.h      |  6 +++---
 include/linux/pagemap.h |  2 +-
 mm/util.c               | 10 +++++-----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a795deef93eb..48fe838723ed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -986,7 +986,7 @@ static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false
 static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
 #endif
 
-int vma_is_stack_for_current(struct vm_area_struct *vma);
+int vma_is_stack_for_current(const struct vm_area_struct *vma);
 
 /* flush_tlb_range() takes a vma, not a mm, and can care about flags */
 #define TLB_FLUSH_VMA(mm,flags) { .vm_mm = (mm), .vm_flags = (flags) }
@@ -2585,7 +2585,7 @@ void folio_add_pin(struct folio *folio);
 
 int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
-			struct task_struct *task, bool bypass_rlim);
+			const struct task_struct *task, bool bypass_rlim);
 
 struct kvec;
 struct page *get_dump_page(unsigned long addr, int *locked);
@@ -3348,7 +3348,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 	     avc; avc = anon_vma_interval_tree_iter_next(avc, start, last))
 
 /* mmap.c */
-extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
+extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
 bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 87411e7f2dba..eb50e0124cd0 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -549,7 +549,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 #endif
 }
 
-struct address_space *folio_mapping(struct folio *);
+struct address_space *folio_mapping(const struct folio *);
 
 /**
  * folio_flush_mapping - Find the file mapping this folio belongs to.
diff --git a/mm/util.c b/mm/util.c
index d235b74f7aff..241d2eaf26ca 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -315,7 +315,7 @@ void *memdup_user_nul(const void __user *src, size_t len)
 EXPORT_SYMBOL(memdup_user_nul);
 
 /* Check if the vma is being used as a stack by this task */
-int vma_is_stack_for_current(struct vm_area_struct *vma)
+int vma_is_stack_for_current(const struct vm_area_struct *vma)
 {
 	struct task_struct * __maybe_unused t = current;
 
@@ -410,7 +410,7 @@ unsigned long arch_mmap_rnd(void)
 	return rnd << PAGE_SHIFT;
 }
 
-static int mmap_is_legacy(struct rlimit *rlim_stack)
+static int mmap_is_legacy(const struct rlimit *rlim_stack)
 {
 	if (current->personality & ADDR_COMPAT_LAYOUT)
 		return 1;
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_IF_KUNIT(arch_pick_mmap_layout);
  * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
  */
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
-			struct task_struct *task, bool bypass_rlim)
+			const struct task_struct *task, bool bypass_rlim)
 {
 	unsigned long locked_vm, limit;
 	int ret = 0;
@@ -688,7 +688,7 @@ struct anon_vma *folio_anon_vma(const struct folio *folio)
  * You can call this for folios which aren't in the swap cache or page
  * cache and it will return NULL.
  */
-struct address_space *folio_mapping(struct folio *folio)
+struct address_space *folio_mapping(const struct folio *folio)
 {
 	struct address_space *mapping;
 
@@ -926,7 +926,7 @@ EXPORT_SYMBOL_GPL(vm_memory_committed);
  * Note this is a helper function intended to be used by LSMs which
  * wish to use this logic.
  */
-int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
+int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin)
 {
 	long allowed;
 	unsigned long bytes_failed;
-- 
2.47.2


