Return-Path: <linux-kernel+bounces-752309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45956B173D9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD97A1F67
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3471DF244;
	Thu, 31 Jul 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNyLDZCA"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DB15A8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975165; cv=none; b=hOWWOXg7teUv0AfXt9QHJWHy7pdlmZjC0ItD+olcJc4NA+298M213veDMrU6kTbFUG/E+fbhcjAK8FbB5rfp0EQ7SnuIb4L2Su5jwcdWMtm6HPl6XN6SyDDyDeAlFKwGq1sD0HybKjAJ/VQp22GkZZDePVIm8ja5zWVkzGDMK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975165; c=relaxed/simple;
	bh=tp534Bj1hk2MlNNKZq7vhy/RVqUsZvTPIy+18UCc5/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iwso6EW9htmmCHIJZhrDH9zGvCD35yIUF7Kd+nlpvTHR273TzCCmcYaQ0RZCwYfFJWKp+FyWAy20wRwdIRSMABcwxuHJ/QHEhZCLV2g+j6m8J2Ah7859pNp3G1xqjAhDxlDz+2NoWZ8DAAAQfGedIdQNzx6L4+P5acJ4+/hSdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNyLDZCA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4225ab1829so775841a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753975163; x=1754579963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rB92jD43gXUv8AEcDtD5VmVQXDaAyFtARma7oKwYEvQ=;
        b=rNyLDZCAZpzSSuZqKHe/yP+AddV39GO3os9CZkcaeKvw/oEwy5VKYueNQj/z72E6O+
         TcJpmT8WqQttMwA26HfLTWfis0x86DUuxthKgeQcpCw23zV+ixtl6t/XjHkHEyWpiagX
         IXbMCUFqA+xF14iKGRdr0aEc6XcwpFtu+D0MD68HoCoP1zm8yuPFMdaS+Via7jydq6VH
         e2ohTewKKf3wOs1NiErerdH2VD7b8ynh5Avrh7Oxukumv9guexqTuDjFdVHpibU28LUg
         bq2zPl9FDayIUBWryMtYb5iQzlTbMgCUF3stxYpnjI+mU2GkqRRdL6r77WaeoNBoX/RR
         2NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975163; x=1754579963;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rB92jD43gXUv8AEcDtD5VmVQXDaAyFtARma7oKwYEvQ=;
        b=wXCeuS2qj72rHMgQ/rXdaYe17sF0ELomFUg/6GrRYeKcA+VIeWO46FrY46idfdObZn
         aD4apcJihgj8XWk0Z40/l3kt1+UFUSqsGZbI2bYEDE5jsnmwgpgV+7XjbZkTwKPW44vk
         Wz2FHn2MNVnGq2Zg6gItkoq0ViDkT0hYfOXJQJzecbH96ZqYBzmOt65nxnjurEim9Wnf
         /A6C9Nb2y2rGy/671qHT7u1A57cmnClSUGgXj6ucW+0a8RA0YXvIqyhB6H90yIcnMzvK
         69If1jr+BVHge8PP0iW4MFg2HWro1PdMlDsgw8fKQJsfNEq3/ZViosBX1FrD1B18tXEP
         byHA==
X-Forwarded-Encrypted: i=1; AJvYcCV/yV94nlyWZb0UgM4ldpLfvtgGcA/ZE1zBEFCpF55iQTwsiBTOrGbyzD/qGFf8FeKyw0HiBM86nOXhsJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtfUu92jWoyxvHz7KdtFi/EVHV0DbKKVflx2OsZgR09txRfqQ
	Xv7CsqVsNlsMM8iD/n9YDqDeN/rd/OOkiHA7hq7vT/btOue13jpBuMAeMC16DwR/3NZRwAzC+vH
	DvGV7DA==
X-Google-Smtp-Source: AGHT+IFycxqU1nsBtsiPJqQ9SIyZmgKdOXZHM3ZE9nPZBjUAHvqIptVuh4EUlzGZst3nTg88jL8l2xDazsk=
X-Received: from pjbqx14.prod.google.com ([2002:a17:90b:3e4e:b0:31f:6a10:6ea6])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c4:b0:31f:44a:229c
 with SMTP id 98e67ed59e1d1-31f5dde6ae1mr12120454a91.12.1753975162973; Thu, 31
 Jul 2025 08:19:22 -0700 (PDT)
Date: Thu, 31 Jul 2025 08:19:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731151919.212829-1-surenb@google.com>
Subject: [PATCH v2 1/2] mm: limit the scope of vma_start_read()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Limit the scope of vma_start_read() as it is used only as a helper for
higher-level locking functions implemented inside mmap_lock.c and we are
about to introduce more complex RCU rules for this function.
The change is pure code refactoring and has no functional changes.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mmap_lock.h | 85 ---------------------------------------
 mm/mmap_lock.c            | 85 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 11a078de9150..2c9fffa58714 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -147,91 +147,6 @@ static inline void vma_refcount_put(struct vm_area_struct *vma)
 	}
 }
 
-/*
- * Try to read-lock a vma. The function is allowed to occasionally yield false
- * locked result to avoid performance overhead, in which case we fall back to
- * using mmap_lock. The function should never yield false unlocked result.
- * False locked result is possible if mm_lock_seq overflows or if vma gets
- * reused and attached to a different mm before we lock it.
- * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
- * detached.
- *
- * WARNING! The vma passed to this function cannot be used if the function
- * fails to lock it because in certain cases RCU lock is dropped and then
- * reacquired. Once RCU lock is dropped the vma can be concurently freed.
- */
-static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
-						    struct vm_area_struct *vma)
-{
-	int oldcnt;
-
-	/*
-	 * Check before locking. A race might cause false locked result.
-	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
-	 * ACQUIRE semantics, because this is just a lockless check whose result
-	 * we don't rely on for anything - the mm_lock_seq read against which we
-	 * need ordering is below.
-	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
-		return NULL;
-
-	/*
-	 * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
-	 * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
-	 * Acquire fence is required here to avoid reordering against later
-	 * vm_lock_seq check and checks inside lock_vma_under_rcu().
-	 */
-	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
-							      VMA_REF_LIMIT))) {
-		/* return EAGAIN if vma got detached from under us */
-		return oldcnt ? NULL : ERR_PTR(-EAGAIN);
-	}
-
-	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
-
-	/*
-	 * If vma got attached to another mm from under us, that mm is not
-	 * stable and can be freed in the narrow window after vma->vm_refcnt
-	 * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
-	 * releasing vma->vm_refcnt.
-	 */
-	if (unlikely(vma->vm_mm != mm)) {
-		/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
-		struct mm_struct *other_mm = vma->vm_mm;
-
-		/*
-		 * __mmdrop() is a heavy operation and we don't need RCU
-		 * protection here. Release RCU lock during these operations.
-		 * We reinstate the RCU read lock as the caller expects it to
-		 * be held when this function returns even on error.
-		 */
-		rcu_read_unlock();
-		mmgrab(other_mm);
-		vma_refcount_put(vma);
-		mmdrop(other_mm);
-		rcu_read_lock();
-		return NULL;
-	}
-
-	/*
-	 * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
-	 * False unlocked result is impossible because we modify and check
-	 * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
-	 * modification invalidates all existing locks.
-	 *
-	 * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
-	 * racing with vma_end_write_all(), we only start reading from the VMA
-	 * after it has been unlocked.
-	 * This pairs with RELEASE semantics in vma_end_write_all().
-	 */
-	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
-		vma_refcount_put(vma);
-		return NULL;
-	}
-
-	return vma;
-}
-
 /*
  * Use only while holding mmap read lock which guarantees that locking will not
  * fail (nobody can concurrently write-lock the vma). vma_start_read() should
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index b006cec8e6fe..10826f347a9f 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -127,6 +127,91 @@ void vma_mark_detached(struct vm_area_struct *vma)
 	}
 }
 
+/*
+ * Try to read-lock a vma. The function is allowed to occasionally yield false
+ * locked result to avoid performance overhead, in which case we fall back to
+ * using mmap_lock. The function should never yield false unlocked result.
+ * False locked result is possible if mm_lock_seq overflows or if vma gets
+ * reused and attached to a different mm before we lock it.
+ * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
+ * detached.
+ *
+ * WARNING! The vma passed to this function cannot be used if the function
+ * fails to lock it because in certain cases RCU lock is dropped and then
+ * reacquired. Once RCU lock is dropped the vma can be concurently freed.
+ */
+static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
+						    struct vm_area_struct *vma)
+{
+	int oldcnt;
+
+	/*
+	 * Check before locking. A race might cause false locked result.
+	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
+	 * ACQUIRE semantics, because this is just a lockless check whose result
+	 * we don't rely on for anything - the mm_lock_seq read against which we
+	 * need ordering is below.
+	 */
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
+		return NULL;
+
+	/*
+	 * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
+	 * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
+	 * Acquire fence is required here to avoid reordering against later
+	 * vm_lock_seq check and checks inside lock_vma_under_rcu().
+	 */
+	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
+							      VMA_REF_LIMIT))) {
+		/* return EAGAIN if vma got detached from under us */
+		return oldcnt ? NULL : ERR_PTR(-EAGAIN);
+	}
+
+	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
+
+	/*
+	 * If vma got attached to another mm from under us, that mm is not
+	 * stable and can be freed in the narrow window after vma->vm_refcnt
+	 * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
+	 * releasing vma->vm_refcnt.
+	 */
+	if (unlikely(vma->vm_mm != mm)) {
+		/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
+		struct mm_struct *other_mm = vma->vm_mm;
+
+		/*
+		 * __mmdrop() is a heavy operation and we don't need RCU
+		 * protection here. Release RCU lock during these operations.
+		 * We reinstate the RCU read lock as the caller expects it to
+		 * be held when this function returns even on error.
+		 */
+		rcu_read_unlock();
+		mmgrab(other_mm);
+		vma_refcount_put(vma);
+		mmdrop(other_mm);
+		rcu_read_lock();
+		return NULL;
+	}
+
+	/*
+	 * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
+	 * False unlocked result is impossible because we modify and check
+	 * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
+	 * modification invalidates all existing locks.
+	 *
+	 * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
+	 * racing with vma_end_write_all(), we only start reading from the VMA
+	 * after it has been unlocked.
+	 * This pairs with RELEASE semantics in vma_end_write_all().
+	 */
+	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
+		vma_refcount_put(vma);
+		return NULL;
+	}
+
+	return vma;
+}
+
 /*
  * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
  * stable and not isolated. If the VMA is not found or is being modified the

base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
-- 
2.50.1.552.g942d659e1b-goog


