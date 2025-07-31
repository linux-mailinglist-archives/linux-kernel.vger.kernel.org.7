Return-Path: <linux-kernel+bounces-752310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A588B173DA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CA07A36A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B41E5B90;
	Thu, 31 Jul 2025 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAYhqvdW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4621DE4D2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975167; cv=none; b=uKjLxmcK1E8GHrcFmJ9zsssu+nBXj4jGnIOs19qHgCVSQ6BZ8L9ySN+KOoD0tmPMITRQ1AQFOHg5dX5AVduN7wm9ro9W9204FFLKgPPqI3ZWt3C7dX6vA0Ol+G69BpLCBTI1R3CDWccSAcJ39q8pu+EOesUULBwQP8b0LTo/1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975167; c=relaxed/simple;
	bh=QPAZ78hFT+nhefwTtIn8MUOVzgEXOS7hUjuUKewsH0s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B0rA8QJKBj46eG4Ynv8JTQM3WMERrB3UpckZ7M1gQeeVnwEW0Ikp/0l3ZwvO71iVYukGpozZk/GQVDDD+OpDgqePQzKce4RuGcwiLP1hUi9qT2g+1dOdk2Bfzv4o21N5GV4vOE5KLjOt2X24AFNbCVwMdfjbeXWLdyhlbDvVRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAYhqvdW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f030b1cb9so1685100a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753975165; x=1754579965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tRIt8AKcHnKINXyvEkxYf94Yh7IhkF311FvqvgzwnyM=;
        b=dAYhqvdWF7bRqA9zV9mbbJJZFTzh8POlcwsJ4kCvi1WEFyH2BQ/isWwYlnwkoufeXx
         Qfr2uGhdENbo3dsuyMRmwZanNgkSpGhEjDBtvxKNkQqLbG66ZsTsXRxZ5R7RnVujROQr
         gbtupOq3relYpyfamfLeSnTCbYUpn4zqPSU/qTYMNKhuErI5k3gB83p6w6wlBGy43Pax
         ZDqHeiA4Ij1HJgrWTIK8TZh1htn0RNZ+kgal0c6z4DjbQLCsstps5EblAaZJKPRaLeLO
         G/5EonCL3wzAcVo9QBe3YRGx1efOO+W9TlbCbxJkUEj4tYqcNNU9T8lMXSe569tzNKug
         4meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975165; x=1754579965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRIt8AKcHnKINXyvEkxYf94Yh7IhkF311FvqvgzwnyM=;
        b=fFJCxsRJiKKYYRHDQEWfueP0A7bmbRGPXdcpGMxv/9taXA0Lrm5iXT7jctICWpAMtz
         amK4sA5vPPxG16TTig98lcM8GdHXaDmSXUb36Gese4h175L7bOBm4hRFg5vEgYlolNqJ
         6rTXb34wjXxNnTXIbC4EJUXAwdqLEkMFwgUnmitwFdpC04AmStiuimW27E+/W4QxP2Dn
         H7vgG4K5Ev0bjMGJ4DYiHk5yYCFNQ2vyXAqcfkSOKC2oqLo12aBqTKt58ksKTVlwhLTn
         oteONa9NVIxLRLTKzWdMlZATUKYLgrQCuKnNK03Q7v7NVsJI3x1pr607DgOwHq/vuZRW
         Tt8g==
X-Forwarded-Encrypted: i=1; AJvYcCXoxkfWZRcG40BMBGbrHT02p5OzF+LBAtRzIV3z2ZoWX380SG2Trpcx7NdzvxvcHkr9aD7uX+LfSTquF3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Gxe2/mp/Fi6U7tlBCsIMYVRL76GFbg3xk9+bJEpD7SGiAhUY
	G3Iif4Rvn/7M3KsPU2gZ6ukcSIo8/O9AzWGzEqowBmnibRadd9dRecXObcgpUHpxvl0Kk2PDot6
	V3gHVhg==
X-Google-Smtp-Source: AGHT+IG+hqz8k3yQGzHNMFz+PXNcZKFUGe9Z5W3kyHUNP/PcUJ2Ofl9W0o8GvY+qmKvXki2uaR6Oh1vSMeI=
X-Received: from pjk16.prod.google.com ([2002:a17:90b:5590:b0:312:151d:c818])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2888:b0:312:959:dc3f
 with SMTP id 98e67ed59e1d1-31f5dd8ca12mr10609509a91.3.1753975165105; Thu, 31
 Jul 2025 08:19:25 -0700 (PDT)
Date: Thu, 31 Jul 2025 08:19:19 -0700
In-Reply-To: <20250731151919.212829-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731151919.212829-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731151919.212829-2-surenb@google.com>
Subject: [PATCH v2 2/2] mm: change vma_start_read() to drop RCU lock on failure
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

vma_start_read() can drop and reacquire RCU lock in certain failure
cases. It's not apparent that the RCU session started by the caller of
this function might be interrupted when vma_start_read() fails to lock
the vma. This might become a source of subtle bugs and to prevent that
we change the locking rules for vma_start_read() to drop RCU read lock
upon failure. This way it's more obvious that RCU-protected objects are
unsafe after vma locking fails.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v1 [1]:
- Fixed missing RCU unlock in lock_vma_under_rcu(), per Lorenzo Stoakes
- Modified comments, per Lorenzo Stoakes

[1] https://lore.kernel.org/all/20250731013405.4066346-2-surenb@google.com/

 mm/mmap_lock.c | 86 +++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 10826f347a9f..7ea603f26975 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -136,15 +136,16 @@ void vma_mark_detached(struct vm_area_struct *vma)
  * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
  * detached.
  *
- * WARNING! The vma passed to this function cannot be used if the function
- * fails to lock it because in certain cases RCU lock is dropped and then
- * reacquired. Once RCU lock is dropped the vma can be concurently freed.
+ * IMPORTANT: RCU lock must be held upon entering the function, but upon error
+ *            IT IS RELEASED. The caller must handle this correctly.
  */
 static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 						    struct vm_area_struct *vma)
 {
+	struct mm_struct *other_mm;
 	int oldcnt;
 
+	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
 	/*
 	 * Check before locking. A race might cause false locked result.
 	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
@@ -152,8 +153,10 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
-		return NULL;
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence)) {
+		vma = NULL;
+		goto err;
+	}
 
 	/*
 	 * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
@@ -164,34 +167,14 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
 							      VMA_REF_LIMIT))) {
 		/* return EAGAIN if vma got detached from under us */
-		return oldcnt ? NULL : ERR_PTR(-EAGAIN);
+		vma = oldcnt ? NULL : ERR_PTR(-EAGAIN);
+		goto err;
 	}
 
 	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
 
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
+	if (unlikely(vma->vm_mm != mm))
+		goto err_unstable;
 
 	/*
 	 * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
@@ -206,10 +189,31 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	 */
 	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
 		vma_refcount_put(vma);
-		return NULL;
+		vma = NULL;
+		goto err;
 	}
 
 	return vma;
+err:
+	rcu_read_unlock();
+
+	return vma;
+err_unstable:
+	/*
+	 * If vma got attached to another mm from under us, that mm is not
+	 * stable and can be freed in the narrow window after vma->vm_refcnt
+	 * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
+	 * releasing vma->vm_refcnt.
+	 */
+	other_mm = vma->vm_mm; /* use a copy as vma can be freed after we drop vm_refcnt */
+
+	/* __mmdrop() is a heavy operation, do it after dropping RCU lock. */
+	rcu_read_unlock();
+	mmgrab(other_mm);
+	vma_refcount_put(vma);
+	mmdrop(other_mm);
+
+	return NULL;
 }
 
 /*
@@ -223,11 +227,13 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	MA_STATE(mas, &mm->mm_mt, address, address);
 	struct vm_area_struct *vma;
 
-	rcu_read_lock();
 retry:
+	rcu_read_lock();
 	vma = mas_walk(&mas);
-	if (!vma)
+	if (!vma) {
+		rcu_read_unlock();
 		goto inval;
+	}
 
 	vma = vma_start_read(mm, vma);
 	if (IS_ERR_OR_NULL(vma)) {
@@ -241,6 +247,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		/* Failed to lock the VMA */
 		goto inval;
 	}
+
+	rcu_read_unlock();
+
 	/*
 	 * At this point, we have a stable reference to a VMA: The VMA is
 	 * locked and we know it hasn't already been isolated.
@@ -249,16 +258,14 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 */
 
 	/* Check if the vma we locked is the right one. */
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
-		goto inval_end_read;
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+		vma_end_read(vma);
+		goto inval;
+	}
 
-	rcu_read_unlock();
 	return vma;
 
-inval_end_read:
-	vma_end_read(vma);
 inval:
-	rcu_read_unlock();
 	count_vm_vma_lock_event(VMA_LOCK_ABORT);
 	return NULL;
 }
@@ -313,6 +320,7 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
 		 */
 		if (PTR_ERR(vma) == -EAGAIN) {
 			/* reset to search from the last address */
+			rcu_read_lock();
 			vma_iter_set(vmi, from_addr);
 			goto retry;
 		}
@@ -342,9 +350,9 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
 	return vma;
 
 fallback_unlock:
+	rcu_read_unlock();
 	vma_end_read(vma);
 fallback:
-	rcu_read_unlock();
 	vma = lock_next_vma_under_mmap_lock(mm, vmi, from_addr);
 	rcu_read_lock();
 	/* Reinitialize the iterator after re-entering rcu read section */
-- 
2.50.1.552.g942d659e1b-goog


