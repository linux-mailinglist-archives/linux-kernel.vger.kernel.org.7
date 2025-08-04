Return-Path: <linux-kernel+bounces-755764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E2EB1AB7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7034B3BF563
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE732918F0;
	Mon,  4 Aug 2025 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bg4xuRlI"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66F2571DC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754350436; cv=none; b=piY/tubLvscwbQkPf1ifKHgjYjdtYikI4OujvKEXjCfuQJLAdpN6Rn9HkMizc3gQ3j0gqzbezliPWbYOfw8JcCIgCfr9eLKU4NNVnG9sgQd0zsO1AGc0vHq6vRuJ0kXm0OKyBcbA1n5N08DzlZBIDF+B9Cmvtx6kvPPtcIufvJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754350436; c=relaxed/simple;
	bh=yTiEk2/KGOTyleRIBPgwnO73+WAPUUF6hsh90Ir3VvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H+EXPnwnCDnBkChhyFq9Ufixh2H10nuETkAHWXi8sZjt3P4IfNnbtn03A9K410addU7tJvMhdLsPOOrG6b7ISlm6DArSfWGAVYJBbAbJtrHfmsd9IelPGw1+Ewir/3Kv5xYFp0GfR0X2aRcrgTEfk5MmttnyK2GAEyDTHhgUZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bg4xuRlI; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b421b03d498so2596832a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754350434; x=1754955234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWnvQbLaliZ0jo0wCZxWQpnIqkjnNecbczSGEo1/eA0=;
        b=Bg4xuRlI8VB8JaYYE2Trberdm10+qjfjeBCcpr8Y7PGEXAHHPBilMWbkfg/ET+jtqY
         y9aX4gbhtYEZnfziwhW+NIw+MMbBQv/d2HEOXl3+SfoQG0IJMeGFv6xAfKtQe+eqVdXK
         8/AbI6cO3sjG3epNm5hb1f/s4/eOnqDgVesMJDF2xtTDuQ7R3dtRpi7SxmrMNnpI5p3h
         mAQXhvToK6C+ISTaSfhmB5Fy0MIXH4RmT0+8y2DHYh4+DSmd6CoRP0zTXhOOpNcOi0QW
         ir/WyMLClJbEhvnN/HPP3ryqkdIokOS7sxDRwLyNfw2udTApO5uw5LJat3NaCTebQa70
         /A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754350434; x=1754955234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWnvQbLaliZ0jo0wCZxWQpnIqkjnNecbczSGEo1/eA0=;
        b=ikxBXFSfB3x+YlN7Bi0LcUZQMZAJpm4rsc1oLh+UxvZzfNSnDOsmy3IgkyHdaWhqzX
         skT8ylvw2J3hxsY58/OHd9OGepGe3szok82A8zd7Qwz7bVnEkofdfI5auDWj1Hq49i8R
         FCl8n+Q4+MruO8637L+CqLRuDuc4XMp3dOy1Hw4Ijm7DJjF08sfnrkjJ8Ro5OvDTCqZ3
         YzKi1p4IRbNMOpRHc/MfBMcGtmdDyC1+iollUY86x2n42V4JY0MyG1bxOi2L1j7JZhFs
         Y8vL91E8nEFVmyTScutJLa0N+Jh1EkWPrG7M+G9PAZafmPqakNDMVgzai/wcLYcrkmoD
         02Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVNP2vUnZwNutDTKiEc5NJcmnPVShG4jEENQF7jpLy/avBLjKygWMi3CQ6oebtCXGpMscK5ydUhaTXgv3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWiovcyNr+ZH0s+grRNuHMGpfIG6a2K8zA7uVrYpUVGUFUk8Yy
	VUlXSMiaMP/jJ5YeFGEqAg5pr7HkR6FoAKPdExCxCwdsNXIYc8tht0CU2kbGV+ReOb6YkgzzcjE
	eVWM4Dg==
X-Google-Smtp-Source: AGHT+IEuCG8ZHqraJFHyrAEoAYUtLmLQWL+oFRwQZZ30kqwMa0dI/KuSFYK+YyoSo6Xb3pey+QxBevkLsEc=
X-Received: from pji11.prod.google.com ([2002:a17:90b:3fcb:b0:311:ff32:a85d])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a03:b0:31c:15da:2175
 with SMTP id 98e67ed59e1d1-321161f0728mr15680679a91.9.1754350434616; Mon, 04
 Aug 2025 16:33:54 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:33:49 -0700
In-Reply-To: <20250804233349.1278678-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804233349.1278678-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804233349.1278678-2-surenb@google.com>
Subject: [PATCH v3 2/2] mm: change vma_start_read() to drop RCU lock on failure
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
Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
Changes since v2 [1]:
- Addressed nit about comment placement, per Vlastimil Babka
- Added Reviewed-by and Tested-by, per Lorenzo Stoakes and
Vlastimil Babka

[1] https://lore.kernel.org/all/20250731151919.212829-2-surenb@google.com/

 mm/mmap_lock.c | 84 +++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 10826f347a9f..0a0db5849b8e 100644
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
@@ -247,18 +253,17 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 * From here on, we can access the VMA without worrying about which
 	 * fields are accessible for RCU readers.
 	 */
+	rcu_read_unlock();
 
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
@@ -313,6 +318,7 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
 		 */
 		if (PTR_ERR(vma) == -EAGAIN) {
 			/* reset to search from the last address */
+			rcu_read_lock();
 			vma_iter_set(vmi, from_addr);
 			goto retry;
 		}
@@ -342,9 +348,9 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
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
2.50.1.565.gc32cd1483b-goog


