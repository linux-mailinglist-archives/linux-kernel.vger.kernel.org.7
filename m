Return-Path: <linux-kernel+bounces-758294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB81B1CD4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111073BD086
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15362C158E;
	Wed,  6 Aug 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CH6KhZEb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kw3urDcB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEBD1C862D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511183; cv=none; b=GmQ3iTv0jv1QYUr9MW9dX/6V35RSwTckKKX50J5b/hb7fwXvVsVkVv+jNhX7trxEFbnUsC98VAf8U/63yQeyfTH4083xhG+0WrcPqpaUMP9HAGv5jR0FseP3US3rU4NELU54/6L58L2DWTGuVNJ+6cO/t5o6pc+NPAl2fsNhx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511183; c=relaxed/simple;
	bh=mptlW4QvppdOxcML4TpyWb/m8EUMoIUssMOWjbfA3d8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GGJfGbss96NTqAsqNMIVasjQcLTiZFNq2XDSjek9EzgytjvzitKWIA5g8v3R2BQyB0e+KZeRNSe1Xo+GgaamxBymrjI1V7kcefAVKopzu119QjiMvOlO8yF0Jr+WXFnAcQv5W+2rJz1hi8kfM2sA2/c/WTZ1PbU8+/0xcAHJgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CH6KhZEb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kw3urDcB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250806200617.450396385@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754511179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Q8ibW5m28of82Bs979FQ4uHADNle8n1fHPOg+oWk1mo=;
	b=CH6KhZEbInrHnzjopUeycuoGdw7RTrV/yaA10H5yaQEuMagU3q29dkGGfBOuRMta6+jW7Z
	2lSxdeP/DS3j3V6t7vcJ4E1fdSFoA40W3si7ep1f0mLw1xZqVwmqkpQiNfyMTJiCCXAJkS
	dL+UBkxmmdjE7B5n+z2LuiW6o1M13dN9z8tmsx4K2k6/hEZOhXWp3c+CROFM3l9gARZU3d
	yl91z39R+P+LVKW4OJh5fijYzvw7EPWCsMb/A7A/mGbVkIVP8zVJ6R/BOaMCSLiCEBVI9V
	ih/r80OQlcLV1ExfuoY4hONymLBS+IRefI4S8X8sqp+CW813iPbyrd6e+5TKUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754511179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Q8ibW5m28of82Bs979FQ4uHADNle8n1fHPOg+oWk1mo=;
	b=Kw3urDcBeZGqwAjYC39VZbU+HvsjmiltVoojaTRUHx5WUjvbrS0Hyp8RzkYl2PKYWLl/LK
	rtKPW7rBm1wIrIBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch 4/6] perf/core: Split out ringbuffer allocation
References: <20250806195624.880096284@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed,  6 Aug 2025 22:12:58 +0200 (CEST)

The code logic in perf_mmap() is incomprehensible and has been source of
subtle bugs in the past. It makes it impossible to convert the atomic_t
reference counts to refcount_t.

There is not really much, which is shared between the ringbuffer and AUX
buffer allocation code since the mlock limit calculation and the
accounting has been split out into helper functions.

Move the AUX buffer allocation code out and integrate the call with a
momentary workaround to allow skipping the remaining ringbuffer related
code completely. That workaround will be removed once the ringbuffer
allocation is moved to its own function as well.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/events/core.c |  134 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 59 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6970,12 +6970,76 @@ static void perf_mmap_account(struct vm_
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
+static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
+			 unsigned long nr_pages)
+{
+	long user_extra = nr_pages, extra = 0;
+	struct perf_buffer *rb = event->rb;
+	u64 aux_offset, aux_size;
+	int ret, rb_flags = 0;
+
+	/*
+	 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
+	 * mapped, all subsequent mappings should have the same size
+	 * and offset. Must be above the normal perf buffer.
+	 */
+	aux_offset = READ_ONCE(rb->user_page->aux_offset);
+	aux_size = READ_ONCE(rb->user_page->aux_size);
+
+	if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
+		return -EINVAL;
+
+	if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
+		return -EINVAL;
+
+	/* Already mapped with a different offset */
+	if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
+		return -EINVAL;
+
+	if (aux_size != nr_pages * PAGE_SIZE)
+		return -EINVAL;
+
+	/* Already mapped with a different size */
+	if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
+		return -EINVAL;
+
+	if (!is_power_of_2(nr_pages))
+		return -EINVAL;
+
+	/* If this succeeds, subsequent failures have to undo it */
+	if (!atomic_inc_not_zero(&rb->mmap_count))
+		return -EINVAL;
+
+	/* If mapped, attach to it */
+	if (rb_has_aux(rb)) {
+		atomic_inc(&rb->aux_mmap_count);
+		return 0;
+	}
+
+	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+		atomic_dec(&rb->mmap_count);
+		return -EPERM;
+	}
+
+	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
+			   event->attr.aux_watermark, rb_flags);
+	if (ret) {
+		atomic_dec(&rb->mmap_count);
+		return ret;
+	}
+
+	atomic_set(&rb->aux_mmap_count, 1);
+	rb->aux_mmap_locked = extra;
+	perf_mmap_account(vma, user_extra, extra);
+	atomic_inc(&event->mmap_count);
+	return 0;
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event = file->private_data;
 	unsigned long vma_size, nr_pages;
 	long user_extra = 0, extra = 0;
-	struct mutex *aux_mutex = NULL;
 	struct perf_buffer *rb = NULL;
 	int ret, flags = 0;
 	mapped_f mapped;
@@ -7055,51 +7119,15 @@ static int perf_mmap(struct file *file,
 		}
 
 	} else {
-		/*
-		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
-		 * mapped, all subsequent mappings should have the same size
-		 * and offset. Must be above the normal perf buffer.
-		 */
-		u64 aux_offset, aux_size;
-
-		rb = event->rb;
-		if (!rb)
-			goto aux_unlock;
-
-		aux_mutex = &rb->aux_mutex;
-		mutex_lock(aux_mutex);
-
-		aux_offset = READ_ONCE(rb->user_page->aux_offset);
-		aux_size = READ_ONCE(rb->user_page->aux_size);
-
-		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
-			goto aux_unlock;
-
-		if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
-			goto aux_unlock;
-
-		/* already mapped with a different offset */
-		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
-			goto aux_unlock;
-
-		if (aux_size != nr_pages * PAGE_SIZE)
-			goto aux_unlock;
-
-		/* already mapped with a different size */
-		if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
-			goto aux_unlock;
-
-		if (!is_power_of_2(nr_pages))
-			goto aux_unlock;
-
-		if (!atomic_inc_not_zero(&rb->mmap_count))
-			goto aux_unlock;
-
-		if (rb_has_aux(rb)) {
-			atomic_inc(&rb->aux_mmap_count);
-			ret = 0;
-			goto unlock;
+		if (event->rb) {
+			ret = -EINVAL;
+		} else {
+			scoped_guard(mutex, &event->rb->aux_mutex)
+				ret = perf_mmap_aux(vma, event, nr_pages);
 		}
+		// Temporary workaround to split out AUX handling first
+		mutex_unlock(&event->mmap_mutex);
+		goto out;
 	}
 
 	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
@@ -7132,28 +7160,16 @@ static int perf_mmap(struct file *file,
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 		ret = 0;
-	} else {
-		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
-				   event->attr.aux_watermark, flags);
-		if (!ret) {
-			atomic_set(&rb->aux_mmap_count, 1);
-			rb->aux_mmap_locked = extra;
-		}
 	}
-
 unlock:
 	if (!ret) {
 		perf_mmap_account(vma, user_extra, extra);
 		atomic_inc(&event->mmap_count);
-	} else if (rb) {
-		/* AUX allocation failed */
-		atomic_dec(&rb->mmap_count);
 	}
-aux_unlock:
-	if (aux_mutex)
-		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
 
+// Temporary until RB allocation is split out.
+out:
 	if (ret)
 		return ret;
 


