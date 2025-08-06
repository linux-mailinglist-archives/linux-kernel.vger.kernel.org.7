Return-Path: <linux-kernel+bounces-758296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F85B1CD4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5785918A217A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CCD2D23A8;
	Wed,  6 Aug 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VzwSij8J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Z0fWs7+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983E2D192B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511186; cv=none; b=PzYlXM9c4ZTbanNSVo+hAaANrJQ0Qrc3+ZUPNpPJv3Jv1f2TBGcfG+D8vQmp7aAOScuaTv0CkWUvg53tIf3AKuqnRpTG8SdHzZzsrPeaYYYYGGla3gIt85AuFBpYYtA6UYaoeN3ojStMyTyCYNT3QV7LWuFKiySmBbzzgs3OwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511186; c=relaxed/simple;
	bh=LM3h/QBg46ucDhqNkB/XC02efGvnIxjitHO3MZLDhus=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=V7vK7vL6nCE+mMRxEdlGoY1lbppfZtUYjSZ2FxQ94Ac2VtjV7DvD500uvqM3mrJQ3u+sQcCntOaeRxwnzM+bN0lUCknzdxk6SDAA0UmjruVZkDHrJvKo0v+MTZkm+GfBHzZy0NKkTlxMZEUe/QEDS4IyIRI4vujcgkNu8YhyZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VzwSij8J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Z0fWs7+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250806200617.576749592@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754511182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XMxUxbXM63hGqWPvFcSsFgioRmubeAKlsk/MQh1rq/g=;
	b=VzwSij8JiOmwhSB0782EgyOtO6o5VN/39XkX3Kelz+lgqRI9SnODEUeZcpf5YDv3zOcHC8
	0FxQEiGQ8S8x8Y1vpwW74JuRTfeLkaub0YAObRhxl/to8SRCzeENVyTR9GtJcsMrhZjVnk
	H0zLIEZ4cwuHiAVKUjSRgyIlF5I0VbWjArF559WpkTvwCJWjGYzKYvMm+xxfqCVmh+vkmu
	wFsLK5ROu0fFxz6UPulgi6lyLM6hJAhkIXVgrj6XQFfqTu7uuw3oslB3x/THMEeb0JRrlO
	eWJVa8rOZzZaqDwhY6Kqa2Z4Txp6IXHw26KciQPCoj56tOESJPUZsT4IvoXn4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754511182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XMxUxbXM63hGqWPvFcSsFgioRmubeAKlsk/MQh1rq/g=;
	b=9Z0fWs7+eYJN3TDS8rxtMqwZt3HyurTslws8wv6Y6IZgM551+uF7KihVwwkNhRwnHgT2Dr
	6dHm56P48kOV/yAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch 6/6] perf/core: Convert mmap() refcounts to refcount_t
References: <20250806195624.880096284@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed,  6 Aug 2025 22:13:02 +0200 (CEST)

The recently fixed reference count leaks could have been detected by using
refcount_t and refcount_t would have mitigated the potential overflow at
least.

Now that the code is properly structured, convert the mmap() related
mmap_count variants over to refcount_t.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
@@ -6990,17 +6990,17 @@ static int perf_mmap_rb(struct vm_area_s
 		if (data_page_nr(rb) != nr_pages)
 			return -EINVAL;
 
-		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
+		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
 			/*
 			 * Success -- managed to mmap() the same buffer
 			 * multiple times.
 			 */
-			atomic_inc(&event->mmap_count);
+			refcount_inc(&event->mmap_count);
 			return 0;
 		}
 		/*
 		 * Raced against perf_mmap_close()'s
-		 * atomic_dec_and_mutex_lock() remove the event and
+		 * refcount_dec_and_mutex_lock() remove the event and
 		 * continue as if !event->rb
 		 */
 		ring_buffer_attach(event, NULL);
@@ -7018,7 +7018,7 @@ static int perf_mmap_rb(struct vm_area_s
 	if (!rb)
 		return -ENOMEM;
 
-	atomic_set(&rb->mmap_count, 1);
+	refcount_set(&rb->mmap_count, 1);
 	rb->mmap_user = get_current_user();
 	rb->mmap_locked = extra;
 
@@ -7029,7 +7029,7 @@ static int perf_mmap_rb(struct vm_area_s
 	perf_event_update_userpage(event);
 
 	perf_mmap_account(vma, user_extra, extra);
-	atomic_set(&event->mmap_count, 1);
+	refcount_set(&event->mmap_count, 1);
 	return 0;
 }
 
@@ -7070,31 +7070,31 @@ static int perf_mmap_aux(struct vm_area_
 		return -EINVAL;
 
 	/* If this succeeds, subsequent failures have to undo it */
-	if (!atomic_inc_not_zero(&rb->mmap_count))
+	if (!refcount_inc_not_zero(&rb->mmap_count))
 		return -EINVAL;
 
 	/* If mapped, attach to it */
 	if (rb_has_aux(rb)) {
-		atomic_inc(&rb->aux_mmap_count);
+		refcount_inc(&rb->aux_mmap_count);
 		return 0;
 	}
 
 	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-		atomic_dec(&rb->mmap_count);
+		refcount_dec(&rb->mmap_count);
 		return -EPERM;
 	}
 
 	ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 			   event->attr.aux_watermark, rb_flags);
 	if (ret) {
-		atomic_dec(&rb->mmap_count);
+		refcount_dec(&rb->mmap_count);
 		return ret;
 	}
 
-	atomic_set(&rb->aux_mmap_count, 1);
+	refcount_set(&rb->aux_mmap_count, 1);
 	rb->aux_mmap_locked = extra;
 	perf_mmap_account(vma, user_extra, extra);
-	atomic_inc(&event->mmap_count);
+	refcount_inc(&event->mmap_count);
 	return 0;
 }
 
@@ -13243,7 +13243,7 @@ perf_event_set_output(struct perf_event
 	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
 set:
 	/* Can't redirect output if we've got an active mmap() */
-	if (atomic_read(&event->mmap_count))
+	if (refcount_read(&event->mmap_count))
 		goto unlock;
 
 	if (output_event) {
@@ -13256,7 +13256,7 @@ perf_event_set_output(struct perf_event
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


