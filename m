Return-Path: <linux-kernel+bounces-751480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B5EB16A25
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3089B4E81FC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7365816F8E9;
	Thu, 31 Jul 2025 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZmKiPlB"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC477104
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753925653; cv=none; b=gtyURcNf86a7j1aw/Kf12SU7uX6ZFRhWQMuLyQl3OTzckPW2YCInzMJY8YoAvNA67313Z1Tn6ZIdcUabcYz6+/45RSSXlFZqAu1WXcip/SNl9IHFsFbFyqYv1hRSOr62hoLuMaJnECs/HACzKcc0BAlTuqd6SUNR2FY9SFkHomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753925653; c=relaxed/simple;
	bh=xJAFYyoIyelit9ISD8qDPTvEHX+t+i50Xv4kPJKzc+A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F3LdrnaBXtf9Qs72XnGv1v5zamUSjl28ZHMM/7EHwebBHR8c22i5+4igzqm72VPuheuxGhP3tu7oGUdK7BBSYZBVWL7tDiB4d83eP+Yns0RkKnOwMyMywfTZclsLcQDuQKGIrQGQIp+gOcx4mpQcInWNJvZR3TEgXfAQEALtBgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZmKiPlB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76b9f10726cso355033b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753925650; x=1754530450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=30lJY2pYa96sEXS83/LQNWaYvxLZIBXFvHOTGDEcIF4=;
        b=BZmKiPlBS1zZLXkkUc07Ub7PPsFcHnTK2BrsP/RwRx+1gQxrHQJMaOUQfcOFXeJvQ4
         qpgXdNGn7woQJvBN0AQK86DRgM6d5JS7H2fgIZu6cFC0mKMMl9MO6dzr01d9BtyIHLwR
         GKXkAjJK++K66OuhjV3hFJO86GQEYLUyfTFeh6oJHk2XifkjEiW8vHPhnnlbHHyMmUDU
         2OrDWUAgz39+0inexGWGjc6IWmvWoDVNipeYNnUP2YsuKKYJBMgCwwlDUMG8lVbcm59x
         9YrDZRmhsOsmg2jLmQyyWtQ1G79rTI4QekanrvlzKvVreHpkTxldlTRyMSD97xnEiNi0
         +jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753925650; x=1754530450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30lJY2pYa96sEXS83/LQNWaYvxLZIBXFvHOTGDEcIF4=;
        b=C0DesMPQGV0IROniLr1OKaxVN7ekkhpn1LbT8yNGY441tyuTYgxmZYY1wFuuAkmE//
         lGL1ZuX7+Eb+ko6iIqo/YJs95WFGQHIY1yODqUhzLrygphY1czunt2UTYP+FsnxwXrym
         i3Q/ifuGX/UTUCLVWCP2+gHaqw+DjwlUuUroE+3D/NkJ4uHcxlj2+7HSq9x11BSj9FOA
         B1saCV1aIwrpYRrivrEuvvScmbKt67AZ3NBeLGCkK/ZgxJ933JpbD2CdIYElTmoe/Ul5
         3jDL4wdFurlOia9uU2fk2+zIPTWKRvlZ8MbIEyGMcD9igButrOios6JlnS0Ua7X2ZZUV
         3RVg==
X-Forwarded-Encrypted: i=1; AJvYcCUkmPhyFRYm603bQ+6EcKt4i289vUKf92yk4fTykPWaYlucKvAqYF0WH3JMQofbtlbUJ1B+sP1vijY1RKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyvYxcubFx8lqutPGElJcOadBesaUK1lA5OJmfMDql4DnH31No
	1CJCCXN9YcC5PQ4GjlMsTLyGHDusuQYEmF48IhmwNROqONN3ZQ0E45Jm3PFKaJtikEQeapiXEew
	e39Khvg==
X-Google-Smtp-Source: AGHT+IGYUSYFqq9ut2qwwG8uB2jzzc7y/YUxC9HqxGAM4IYnR2gPpcg8Thc8TWH7ouQHpVQc3spF01BUWGQ=
X-Received: from pghl11.prod.google.com ([2002:a63:f30b:0:b0:b42:fe:62e2])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d24:b0:23d:b4cf:c834
 with SMTP id adf61e73a8af0-23dc0ec6837mr8924328637.22.1753925650327; Wed, 30
 Jul 2025 18:34:10 -0700 (PDT)
Date: Wed, 30 Jul 2025 18:34:04 -0700
In-Reply-To: <20250731013405.4066346-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731013405.4066346-1-surenb@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250731013405.4066346-2-surenb@google.com>
Subject: [PATCH 2/2] mm: change vma_start_read() to drop RCU lock on failure
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
 mm/mmap_lock.c | 76 +++++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 10826f347a9f..0129db8f652f 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -136,15 +136,21 @@ void vma_mark_detached(struct vm_area_struct *vma)
  * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
  * detached.
  *
- * WARNING! The vma passed to this function cannot be used if the function
- * fails to lock it because in certain cases RCU lock is dropped and then
- * reacquired. Once RCU lock is dropped the vma can be concurently freed.
+ * WARNING! On entrance to this function RCU read lock should be held and it
+ * is released if function fails to lock the vma, therefore vma passed to this
+ * function cannot be used if the function fails to lock it.
+ * When vma is successfully locked, RCU read lock is kept intact and RCU read
+ * session is not interrupted. This is important when locking is done while
+ * walking the vma tree under RCU using vma_iterator because if the RCU lock
+ * is dropped, the iterator becomes invalid.
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
@@ -152,8 +158,10 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
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
@@ -164,7 +172,8 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
 							      VMA_REF_LIMIT))) {
 		/* return EAGAIN if vma got detached from under us */
-		return oldcnt ? NULL : ERR_PTR(-EAGAIN);
+		vma = oldcnt ? NULL : ERR_PTR(-EAGAIN);
+		goto err;
 	}
 
 	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
@@ -175,23 +184,8 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
 	 * is dropped and before rcuwait_wake_up(mm) is called. Grab it before
 	 * releasing vma->vm_refcnt.
 	 */
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
@@ -206,10 +200,26 @@ static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm,
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
+	/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
+	other_mm = vma->vm_mm;
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
@@ -223,8 +233,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	MA_STATE(mas, &mm->mm_mt, address, address);
 	struct vm_area_struct *vma;
 
-	rcu_read_lock();
 retry:
+	rcu_read_lock();
 	vma = mas_walk(&mas);
 	if (!vma)
 		goto inval;
@@ -241,6 +251,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 		/* Failed to lock the VMA */
 		goto inval;
 	}
+
+	rcu_read_unlock();
+
 	/*
 	 * At this point, we have a stable reference to a VMA: The VMA is
 	 * locked and we know it hasn't already been isolated.
@@ -249,16 +262,14 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
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
@@ -313,6 +324,7 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
 		 */
 		if (PTR_ERR(vma) == -EAGAIN) {
 			/* reset to search from the last address */
+			rcu_read_lock();
 			vma_iter_set(vmi, from_addr);
 			goto retry;
 		}
@@ -342,9 +354,9 @@ struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
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


