Return-Path: <linux-kernel+bounces-755763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A8DB1AB79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D34B18A2BE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71696286D4D;
	Mon,  4 Aug 2025 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZF1uumfn"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEE2E36ED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754350434; cv=none; b=qiJx++Tyu12NODWh0BKZIXNdgha+h4ECRTyMHrcdNsG5qAfm3u6kKugB7DquGUMbaGbz1OTPk5/zTSo44iUAt+N2+AFlDQVVLITl/zoIXmpaXzUV9vNr6uX2ZqTg3zIjNlmitKur84P2cVYUco+Qc+Vq9z1ljrf8d0EIrYjtWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754350434; c=relaxed/simple;
	bh=XaOxYAk1Kw7hLvLrwchFSXNCQPHOMgTTHGllHbe+ePo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=esVuqpQTUV7/SnwY6Vl3Kv12kG+dOCR/onA/RQkCifZoR73HmSsHU3M28ZoYaJRsjNGqzp1WGAxb3aRuLJimjyP42MdyYM7fUISkXl4ovND4wj3EdCZr2e7uUSBvJ50v8J0SRTW83NlM3zAAkYu/MFzfqYvl1GA2oaJWUGY84uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZF1uumfn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23fe26e5a33so60136095ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754350432; x=1754955232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K8kBr0sEdWPq/rMgi5JjXlkIUuqL1mTAE0S/a8VUHQA=;
        b=ZF1uumfnmaO+/gIItxjxxD0W8xI+JPqBiR0MtGYwApkrTkddGVeTU5FjK476T3Geft
         IzBvTcYKXq/oMXLQBrCcyov7WVn3ZPkW1ptly2+ATdADyP01UhJ6V5qxW09fJTq5L4Nz
         8wTuht2HECvDSx2SvGc132Ch9vmEImPQxi1F72oFHyiThde9kFLjlZNuJtWwKO/z/ops
         MQ9VWB8AWNrtMj8117INV3AuBdrsaFwrS9cboqVSLEIcBSdOegleeGgZzOZAQyFvCrTe
         v/F2IHvA/3bGmEWtxobbZZXaVqX2Df68RpUZwF1xZwEM5Lkm/951czajGisVSM9ic+H9
         JFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754350432; x=1754955232;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8kBr0sEdWPq/rMgi5JjXlkIUuqL1mTAE0S/a8VUHQA=;
        b=ipy+KBm0F17tUfccljBzlbxLvKi+DYq+bouxUY93G+oal1GE0n/htoYgkM6WNPGo/l
         EEaNVXBeLDYqGnUqCBnbxdvn1OFXioXFAwM5X23cveo8huXViPTFQ5u+DpwsavNbdb+t
         UmsOtkgNteBZmxrDSGKUt5fTm0HNi7YeYR4RGrY1SqDx70532IdCAPr8zuMrwYfRJCHO
         NMRMlhf6tQ/WdvTBDE4nqIY2g1DMehaUgPnJmVn3ooTfxh/1ahcrQi2+c+3Vy3Ck4c3/
         YyEzy/8zBMyfWteaE2dJLDAGyixRlsjC1mTcryJYSksSyK6F6OIOMnb8ACml1+esJHXg
         RrJA==
X-Forwarded-Encrypted: i=1; AJvYcCWMuw2zInv2adLZmvzQMR2ZtTdkssabAuYBfaVgPJ1Vh/faqZf+UACRw6fejcMq+P8TJh766IqqC5MqGSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZX4baVTCufQrGqyZXTOb/LEVyhrcsod10G/DixBpyrGXvZJlA
	vZ0G4SfHZh6Ubk2sWl+lwPBLDcbOi172Wkx+WIZRP+0N+XX5xLyIOBaoDi/eyh2nTUvVT8IGUKW
	RgvjLgA==
X-Google-Smtp-Source: AGHT+IGsJpocfloOVPr6u9A95As5/2zobosaAdFactB/XqeVKMru/t83xLTZYroGA2eQMfT7vptdCESTqYI=
X-Received: from plbli8.prod.google.com ([2002:a17:903:2948:b0:23f:d6f2:cb9d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c8:b0:234:d292:be95
 with SMTP id d9443c01a7336-2424703f838mr146561815ad.42.1754350432369; Mon, 04
 Aug 2025 16:33:52 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:33:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804233349.1278678-1-surenb@google.com>
Subject: [PATCH v3 1/2] mm: limit the scope of vma_start_read()
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
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
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
2.50.1.565.gc32cd1483b-goog


