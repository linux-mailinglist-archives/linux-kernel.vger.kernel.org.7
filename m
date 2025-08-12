Return-Path: <linux-kernel+bounces-764591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DCFB224E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413A14255AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928C2ED847;
	Tue, 12 Aug 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n9hfjeRj"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BBB2EBDD4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995576; cv=none; b=CY6Z5HQORumQKSCz0NdUaM9Rr50xnMuMjhNzx7TSZ0TgPuhyXG1jy9tUZH5KF9ZGf3tWWfUYuRIv6iZwNNGmO2UbvrO1JcvuUhm7P503Aiuhhy3gdQrTNAgxa8lgU28ts/y4NZz8+0u1v87NsB0s6hkh+n8mO3M5R+j0B2nhR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995576; c=relaxed/simple;
	bh=Spl98Pg3sChTHHYAUT6cfpeEUlAt9SX1VxXqypPEddA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IMdjb+wH5iOQ/cyNi3dNc/ifmVZHS2Dv37leXuNkqEcxRTCj2gy3zg8kD7LBf9jMguARcPzuZZaM6rBDscAeJPOZIRXMhwSW4y4ljKdyqDA/Sjusx/q2Een+rfpsLn1041L0XMyzqEyWj+fJ6fWCOx0FMYrDRhrowH34DcGH/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n9hfjeRj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=YWkfcPUrzQAlnpEnb8Fccs5Qm2U3D45YEUaPiQ4jQPo=; b=n9hfjeRj/F48Ut3LQ0pAu4jGP1
	w1HfvQY0UuYzUEDzYmq2MAqMv6Q6AWdKNeITohjlEWCcIo1rrNjpuEEO/IMrQxAuag/LtWJQ56qUo
	NUo2Mq3DrFrCecq7OwzlpYwjGPgbtt+CvOhlT1fNC86EExyIOzxcWv0gGRZU7dB3QIFgu0fHkrMbf
	ODYvRpmtb6RSbtDmYJNrncRFz3qYVpHRt8o0u5osdoAwuAsBf97o+5jBEuxRFmfRWXA/x4Fh9devX
	QYeWE7N6N2dFQUUnflZabtOLFWxuBDrc6XaGONu0VK5mFNCNs/4AJDwgSJkPHXtvYgTzZUssHc3Aw
	CzlJv4Gw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWB-0000000FmkD-2yBv;
	Tue, 12 Aug 2025 10:46:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CA184302EEA; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104020.071507932@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 15/15] perf: Convert mmap() refcounts to refcount_t
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thomas Gleixner <tglx@linutronix.de>

The recently fixed reference count leaks could have been detected by using
refcount_t and refcount_t would have mitigated the potential overflow at
least.

Now that the code is properly structured, convert the mmap() related
mmap_count variants over to refcount_t.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250811070620.716309215@linutronix.de
---
 include/linux/perf_event.h  |    2 +-
 kernel/events/core.c        |   40 ++++++++++++++++++++--------------------
 kernel/events/internal.h    |    4 ++--
 kernel/events/ring_buffer.c |    2 +-
 4 files changed, 24 insertions(+), 24 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -859,7 +859,7 @@ struct perf_event {
 
 	/* mmap bits */
 	struct mutex			mmap_mutex;
-	atomic_t			mmap_count;
+	refcount_t			mmap_count;
 
 	struct perf_buffer		*rb;
 	struct list_head		rb_entry;
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3968,7 +3968,7 @@ static noinline int visit_groups_merge(s
  */
 static inline bool event_update_userpage(struct perf_event *event)
 {
-	if (likely(!atomic_read(&event->mmap_count)))
+	if (likely(!refcount_read(&event->mmap_count)))
 		return false;
 
 	perf_event_update_time(event);
@@ -6704,11 +6704,11 @@ static void perf_mmap_open(struct vm_are
 	struct perf_event *event = vma->vm_file->private_data;
 	mapped_f mapped = get_mapped(event, event_mapped);
 
-	atomic_inc(&event->mmap_count);
-	atomic_inc(&event->rb->mmap_count);
+	refcount_inc(&event->mmap_count);
+	refcount_inc(&event->rb->mmap_count);
 
 	if (vma->vm_pgoff)
-		atomic_inc(&event->rb->aux_mmap_count);
+		refcount_inc(&event->rb->aux_mmap_count);
 
 	if (mapped)
 		mapped(event, vma->vm_mm);
@@ -6743,7 +6743,7 @@ static void perf_mmap_close(struct vm_ar
 	 * to avoid complications.
 	 */
 	if (rb_has_aux(rb) && vma->vm_pgoff == rb->aux_pgoff &&
-	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
+	    refcount_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
 		/*
 		 * Stop all AUX events that are writing to this buffer,
 		 * so that we can free its AUX pages and corresponding PMU
@@ -6763,10 +6763,10 @@ static void perf_mmap_close(struct vm_ar
 		mutex_unlock(&rb->aux_mutex);
 	}
 
-	if (atomic_dec_and_test(&rb->mmap_count))
+	if (refcount_dec_and_test(&rb->mmap_count))
 		detach_rest = true;
 
-	if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
+	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
 		goto out_put;
 
 	ring_buffer_attach(event, NULL);
@@ -6992,19 +6992,19 @@ static int perf_mmap_rb(struct vm_area_s
 		if (data_page_nr(event->rb) != nr_pages)
 			return -EINVAL;
 
-		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
+		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
 			/*
 			 * Success -- managed to mmap() the same buffer
 			 * multiple times.
 			 */
 			perf_mmap_account(vma, user_extra, extra);
-			atomic_inc(&event->mmap_count);
+			refcount_inc(&event->mmap_count);
 			return 0;
 		}
 
 		/*
 		 * Raced against perf_mmap_close()'s
-		 * atomic_dec_and_mutex_lock() remove the
+		 * refcount_dec_and_mutex_lock() remove the
 		 * event and continue as if !event->rb
 		 */
 		ring_buffer_attach(event, NULL);
@@ -7023,7 +7023,7 @@ static int perf_mmap_rb(struct vm_area_s
 	if (!rb)
 		return -ENOMEM;
 
-	atomic_set(&rb->mmap_count, 1);
+	refcount_set(&rb->mmap_count, 1);
 	rb->mmap_user = get_current_user();
 	rb->mmap_locked = extra;
 
@@ -7034,7 +7034,7 @@ static int perf_mmap_rb(struct vm_area_s
 	perf_event_update_userpage(event);
 
 	perf_mmap_account(vma, user_extra, extra);
-	atomic_set(&event->mmap_count, 1);
+	refcount_set(&event->mmap_count, 1);
 
 	return 0;
 }
@@ -7081,15 +7081,15 @@ static int perf_mmap_aux(struct vm_area_
 	if (!is_power_of_2(nr_pages))
 		return -EINVAL;
 
-	if (!atomic_inc_not_zero(&rb->mmap_count))
+	if (!refcount_inc_not_zero(&rb->mmap_count))
 		return -EINVAL;
 
 	if (rb_has_aux(rb)) {
-		atomic_inc(&rb->aux_mmap_count);
+		refcount_inc(&rb->aux_mmap_count);
 
 	} else {
 		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-			atomic_dec(&rb->mmap_count);
+			refcount_dec(&rb->mmap_count);
 			return -EPERM;
 		}
 
@@ -7101,16 +7101,16 @@ static int perf_mmap_aux(struct vm_area_
 		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 				   event->attr.aux_watermark, rb_flags);
 		if (ret) {
-			atomic_dec(&rb->mmap_count);
+			refcount_dec(&rb->mmap_count);
 			return ret;
 		}
 
-		atomic_set(&rb->aux_mmap_count, 1);
+		refcount_set(&rb->aux_mmap_count, 1);
 		rb->aux_mmap_locked = extra;
 	}
 
 	perf_mmap_account(vma, user_extra, extra);
-	atomic_inc(&event->mmap_count);
+	refcount_inc(&event->mmap_count);
 
 	return 0;
 }
@@ -13257,7 +13257,7 @@ perf_event_set_output(struct perf_event
 	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
 set:
 	/* Can't redirect output if we've got an active mmap() */
-	if (atomic_read(&event->mmap_count))
+	if (refcount_read(&event->mmap_count))
 		goto unlock;
 
 	if (output_event) {
@@ -13270,7 +13270,7 @@ perf_event_set_output(struct perf_event
 			goto unlock;
 
 		/* did we race against perf_mmap_close() */
-		if (!atomic_read(&rb->mmap_count)) {
+		if (!refcount_read(&rb->mmap_count)) {
 			ring_buffer_put(rb);
 			goto unlock;
 		}
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -35,7 +35,7 @@ struct perf_buffer {
 	spinlock_t			event_lock;
 	struct list_head		event_list;
 
-	atomic_t			mmap_count;
+	refcount_t			mmap_count;
 	unsigned long			mmap_locked;
 	struct user_struct		*mmap_user;
 
@@ -47,7 +47,7 @@ struct perf_buffer {
 	unsigned long			aux_pgoff;
 	int				aux_nr_pages;
 	int				aux_overwrite;
-	atomic_t			aux_mmap_count;
+	refcount_t			aux_mmap_count;
 	unsigned long			aux_mmap_locked;
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -400,7 +400,7 @@ void *perf_aux_output_begin(struct perf_
 	 * the same order, see perf_mmap_close. Otherwise we end up freeing
 	 * aux pages in this path, which is a bug, because in_atomic().
 	 */
-	if (!atomic_read(&rb->aux_mmap_count))
+	if (!refcount_read(&rb->aux_mmap_count))
 		goto err;
 
 	if (!refcount_inc_not_zero(&rb->aux_refcount))



