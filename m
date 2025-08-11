Return-Path: <linux-kernel+bounces-762605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F79B208E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938957A435D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8132D5A11;
	Mon, 11 Aug 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1TGX0b7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3DFcm1Dz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2326DF6C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915802; cv=none; b=YkSRBBkluko5OY7MM0Ty8YTfAi5QS5U6mtf6YUDw7T4Mwpwpbwc1f6sNtKKYv3onFfcyrM+j/uLAM7BFpSProbIm7rYmzaTkR/zfthIFiAF36OT1axpThamWWFAKkz70KsLgja+ZkZlly5hJhDL5H6WghqDAO5rvi4Rqx25/NUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915802; c=relaxed/simple;
	bh=FEc5GMnUi7mJm/XzdzVLhMj2oiOHCX+/YBfdt4rqCd4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Jgj+sWMDs5YmE0mTS1Y/PKS5kwIuj0G01gGT2KroPmw2MRsRwx3iVmUTvsmk+DsujEZ1XJv94fQxIT3Ng/TwG+c+4hZBnrRzsT1EARdg3cG0SKDamv8dcK7EtM8RDO/xOY9p6jAYdyob/9oj0rYXW0v9BsmTzw+XApXVAFCpkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M1TGX0b7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3DFcm1Dz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250811123609.729827000@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754915798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pjj53Fgh7h/2kT6GSXP6CzlouVFlDccVJfXMfSRVyvE=;
	b=M1TGX0b7wxgd194rNErtRxEeULcFOIO9bpnkhTuUwK2i6XDD2NOUVcWfIGD3rtyizNr4Yi
	E4fMwvzCLrIc3VNuPT2FcRdm2gBBmE3MCSl1bamBB4vCnCzA/ND1diG4+6IuIxezTcbqg9
	X0kUkTf3CFR29eff3SO8hF4SSkqRLE+2C8zBdlWG+GCcsuY1z9I/MchMtyESnIQrIBVM5d
	Dz79GO/BG4HlCoR4ySOyvwRYeNvHuAtRrqBHMChtknFPSy65oXbk8wCAUPaQx3rXYxcRSz
	3XAuxiVofGDClozb5SdgW5H9XeextZ7ZB7m+DYdXJf0YkZSuZp3N9Rqo7Zgiqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754915798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pjj53Fgh7h/2kT6GSXP6CzlouVFlDccVJfXMfSRVyvE=;
	b=3DFcm1Dzbtsl9UKsAyIXRsCJr0KfS60Zh+dfJuj59wdCZ/jT806qthupsxgC1Va1BXW6X4
	nc8FXmJs9l8HeUAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch V2 RESEND 5/6] perf/core: Split the ringbuffer mmap() and
 allocation code out
References: <20250811123458.050061356@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 14:36:37 +0200 (CEST)

The code logic in perf_mmap() is incomprehensible and has been source of
subtle bugs in the past. It makes it impossible to convert the atomic_t
reference counts to refcount_t.

Now that the AUX buffer mapping and allocation code is in it's own function
apply the same treatment to the ringbuffer part and remove the temporary
workarounds created by the AUX split out.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/events/core.c |  176 ++++++++++++++++++++++-----------------------------
 1 file changed, 78 insertions(+), 98 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6970,6 +6970,70 @@ static void perf_mmap_account(struct vm_
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
+static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
+			unsigned long nr_pages)
+{
+	long user_extra = nr_pages, extra = 0;
+	struct perf_buffer *rb = event->rb;
+	int rb_flags = 0;
+
+	/*
+	 * If we have rb pages ensure they're a power-of-two number, so we
+	 * can do bitmasks instead of modulo.
+	 */
+	if (--nr_pages != 0 && !is_power_of_2(nr_pages))
+		return -EINVAL;
+
+	WARN_ON_ONCE(event->ctx->parent_ctx);
+
+	if (rb) {
+		/* Must have the same size */
+		if (data_page_nr(rb) != nr_pages)
+			return -EINVAL;
+
+		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
+			/*
+			 * Success -- managed to mmap() the same buffer
+			 * multiple times.
+			 */
+			atomic_inc(&event->mmap_count);
+			return 0;
+		}
+		/*
+		 * Raced against perf_mmap_close()'s
+		 * atomic_dec_and_mutex_lock() remove the event and
+		 * continue as if !event->rb
+		 */
+		ring_buffer_attach(event, NULL);
+	}
+
+	if (!perf_mmap_calc_limits(vma, &user_extra, &extra))
+		return -EPERM;
+
+	if (vma->vm_flags & VM_WRITE)
+		rb_flags |= RING_BUFFER_WRITABLE;
+
+	rb = rb_alloc(nr_pages, event->attr.watermark ? event->attr.wakeup_watermark : 0,
+		      event->cpu, rb_flags);
+
+	if (!rb)
+		return -ENOMEM;
+
+	atomic_set(&rb->mmap_count, 1);
+	rb->mmap_user = get_current_user();
+	rb->mmap_locked = extra;
+
+	ring_buffer_attach(event, rb);
+
+	perf_event_update_time(event);
+	perf_event_init_userpage(event);
+	perf_event_update_userpage(event);
+
+	perf_mmap_account(vma, user_extra, extra);
+	atomic_set(&event->mmap_count, 1);
+	return 0;
+}
+
 static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 			 unsigned long nr_pages)
 {
@@ -7042,10 +7106,8 @@ static int perf_mmap(struct file *file,
 {
 	struct perf_event *event = file->private_data;
 	unsigned long vma_size, nr_pages;
-	long user_extra = 0, extra = 0;
-	struct perf_buffer *rb = NULL;
-	int ret, flags = 0;
 	mapped_f mapped;
+	int ret;
 
 	/*
 	 * Don't allow mmap() of inherited per-task counters. This would
@@ -7071,114 +7133,32 @@ static int perf_mmap(struct file *file,
 	if (vma_size != PAGE_SIZE * nr_pages)
 		return -EINVAL;
 
-	user_extra = nr_pages;
-
-	mutex_lock(&event->mmap_mutex);
-	ret = -EINVAL;
-
-	/*
-	 * This relies on __pmu_detach_event() taking mmap_mutex after marking
-	 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
-	 * will detach the rb created here.
-	 */
-	if (event->state <= PERF_EVENT_STATE_REVOKED) {
-		ret = -ENODEV;
-		goto unlock;
-	}
-
-	if (vma->vm_pgoff == 0) {
-		nr_pages -= 1;
-
+	scoped_guard(mutex, &event->mmap_mutex) {
 		/*
-		 * If we have rb pages ensure they're a power-of-two number, so we
-		 * can do bitmasks instead of modulo.
+		 * This relies on __pmu_detach_event() taking mmap_mutex
+		 * after marking the event REVOKED. Either we observe the
+		 * state, or __pmu_detach_event() will detach the rb
+		 * created here.
 		 */
-		if (nr_pages != 0 && !is_power_of_2(nr_pages))
-			goto unlock;
-
-		WARN_ON_ONCE(event->ctx->parent_ctx);
+		if (event->state <= PERF_EVENT_STATE_REVOKED)
+			return -ENODEV;
 
-		if (event->rb) {
-			if (data_page_nr(event->rb) != nr_pages)
-				goto unlock;
-
-			if (atomic_inc_not_zero(&event->rb->mmap_count)) {
-				/*
-				 * Success -- managed to mmap() the same buffer
-				 * multiple times.
-				 */
-				ret = 0;
-				/* We need the rb to map pages. */
-				rb = event->rb;
-				goto unlock;
-			}
-
-			/*
-			 * Raced against perf_mmap_close()'s
-			 * atomic_dec_and_mutex_lock() remove the
-			 * event and continue as if !event->rb
-			 */
-			ring_buffer_attach(event, NULL);
-		}
-
-	} else {
-		if (!event->rb) {
-			ret = -EINVAL;
+		if (vma->vm_pgoff == 0) {
+			ret = perf_mmap_rb(vma, event, nr_pages);
 		} else {
+			if (!event->rb)
+				return -EINVAL;
 			scoped_guard(mutex, &event->rb->aux_mutex)
 				ret = perf_mmap_aux(vma, event, nr_pages);
 		}
-		// Temporary workaround to split out AUX handling first
-		mutex_unlock(&event->mmap_mutex);
-		goto out;
-	}
-
-	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-		ret = -EPERM;
-		goto unlock;
-	}
-
-	WARN_ON(!rb && event->rb);
-
-	if (vma->vm_flags & VM_WRITE)
-		flags |= RING_BUFFER_WRITABLE;
-
-	if (!rb) {
-		rb = rb_alloc(nr_pages,
-			      event->attr.watermark ? event->attr.wakeup_watermark : 0,
-			      event->cpu, flags);
-
-		if (!rb) {
-			ret = -ENOMEM;
-			goto unlock;
-		}
-
-		atomic_set(&rb->mmap_count, 1);
-		rb->mmap_user = get_current_user();
-		rb->mmap_locked = extra;
-
-		ring_buffer_attach(event, rb);
-
-		perf_event_update_time(event);
-		perf_event_init_userpage(event);
-		perf_event_update_userpage(event);
-		ret = 0;
-	}
-unlock:
-	if (!ret) {
-		perf_mmap_account(vma, user_extra, extra);
-		atomic_inc(&event->mmap_count);
 	}
-	mutex_unlock(&event->mmap_mutex);
 
-// Temporary until RB allocation is split out.
-out:
 	if (ret)
 		return ret;
 
 	/*
 	 * Since pinned accounting is per vm we cannot allow fork() to copy our
-	 * vma.
+	 * VMA. The VMA is fixed size and must not be included in dumps.
 	 */
 	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &perf_mmap_vmops;
@@ -7193,7 +7173,7 @@ static int perf_mmap(struct file *file,
 	 * full cleanup in this case and therefore does not invoke
 	 * vmops::close().
 	 */
-	ret = map_range(rb, vma);
+	ret = map_range(event->rb, vma);
 	if (ret)
 		perf_mmap_close(vma);
 


