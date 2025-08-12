Return-Path: <linux-kernel+bounces-764590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641F9B224DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305815009B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7522ED845;
	Tue, 12 Aug 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jidkELdJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7E2EBDD5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995576; cv=none; b=kVi3vimJmUNTeCy2MVXlqo9QVfaEnwHLlvM3llxI7uuslnKANsWBvKl1j3T+PFeOYMenhKLVW5iuVhxlmxHfpVdgfgZ6e6NyTup2i6fyk3UpR0ltg+BoYkbKBA0VzfJmFNAQTaTA83T2gkfWp+RkdtpNo5oyMHbs0CL4dyZEmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995576; c=relaxed/simple;
	bh=zsUoYfmrwBZufVYd2oSJFDKq0MGsmEWxFkUupdw1aGI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lMN2Q0Ry6YG/uTZvgb9lDFjucIh7S1y3lwVp6H/G/Og9ePMFohuGBJVIcjqNO0JVNatSGQOBQNyYBOb1j+JNEH8yNkyDxmULNiJIEALSdyf09Mg+7ixidwkZWWKH+8JLxgSAYX4s8HR5brVvMxKgocn5jcPYCprUoPhA1ZSfxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jidkELdJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=vH3yePd5DKCVSO1Y/zfCgO448JmB78RevnyS2SQs/eI=; b=jidkELdJqhmcWelCr6GAeNRiln
	KoG1RQHgfe9N3+rujY9rU0s+6UrY5BHueu5MYqJtZyWenhNvA0eo/AzckxcjcE5ALqBgeZrQqJpxN
	mcc8FQGZ/tMiVJp/yrvEvXCHeCecBO7oYdwwBeyoFhRVL7bAfqOEP2ZQLuhwxXO1/9wjcElhQLSCJ
	jOVjF9A/4ggMm33cZNxM7mJOFfer1PbdDOHHgzt3DZogkcqGIinG62G/6NwwrvPP0clhwAQsD+6oW
	9Vfde9OVXAj0ko0Xhc4cwTFn2YdDtjo3afSnSetMbVNn4y88bXD7Sp82UTN+aNPDEK0OHPL4ES4RO
	YQ1SYtgw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWB-0000000FmkA-21YP;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BB4F9302E5F; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.722214699@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 12/15] perf: Split out the RB allocation
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Move the RB buffer allocation branch into its own function.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |  145 +++++++++++++++++++++++++--------------------------
 1 file changed, 73 insertions(+), 72 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6970,6 +6970,75 @@ static void perf_mmap_account(struct vm_
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
+static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
+			unsigned long nr_pages)
+{
+	long extra = 0, user_extra = nr_pages;
+	struct perf_buffer *rb;
+	int rb_flags = 0;
+
+	nr_pages -= 1;
+
+	/*
+	 * If we have rb pages ensure they're a power-of-two number, so we
+	 * can do bitmasks instead of modulo.
+	 */
+	if (nr_pages != 0 && !is_power_of_2(nr_pages))
+		return -EINVAL;
+
+	WARN_ON_ONCE(event->ctx->parent_ctx);
+
+	if (event->rb) {
+		if (data_page_nr(event->rb) != nr_pages)
+			return -EINVAL;
+
+		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
+			/*
+			 * Success -- managed to mmap() the same buffer
+			 * multiple times.
+			 */
+			perf_mmap_account(vma, user_extra, extra);
+			atomic_inc(&event->mmap_count);
+			return 0;
+		}
+
+		/*
+		 * Raced against perf_mmap_close()'s
+		 * atomic_dec_and_mutex_lock() remove the
+		 * event and continue as if !event->rb
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
+	rb = rb_alloc(nr_pages,
+		      event->attr.watermark ? event->attr.wakeup_watermark : 0,
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
+	atomic_inc(&event->mmap_count);
+
+	return 0;
+}
+
 static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 			 unsigned long nr_pages)
 {
@@ -7050,10 +7119,8 @@ static int perf_mmap(struct file *file,
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
@@ -7079,8 +7146,6 @@ static int perf_mmap(struct file *file,
 	if (vma_size != PAGE_SIZE * nr_pages)
 		return -EINVAL;
 
-	user_extra = nr_pages;
-
 	mutex_lock(&event->mmap_mutex);
 	ret = -EINVAL;
 
@@ -7094,74 +7159,10 @@ static int perf_mmap(struct file *file,
 		goto unlock;
 	}
 
-	if (vma->vm_pgoff == 0) {
-		nr_pages -= 1;
-
-		/*
-		 * If we have rb pages ensure they're a power-of-two number, so we
-		 * can do bitmasks instead of modulo.
-		 */
-		if (nr_pages != 0 && !is_power_of_2(nr_pages))
-			goto unlock;
-
-		WARN_ON_ONCE(event->ctx->parent_ctx);
-
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
-				perf_mmap_account(vma, user_extra, extra);
-				atomic_inc(&event->mmap_count);
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
-		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-			ret = -EPERM;
-			goto unlock;
-		}
-
-		if (vma->vm_flags & VM_WRITE)
-			flags |= RING_BUFFER_WRITABLE;
-
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
-
-		perf_mmap_account(vma, user_extra, extra);
-		atomic_inc(&event->mmap_count);
-	} else {
+	if (vma->vm_pgoff == 0)
+		ret = perf_mmap_rb(vma, event, nr_pages);
+	else
 		ret = perf_mmap_aux(vma, event, nr_pages);
-	}
 
 unlock:
 	mutex_unlock(&event->mmap_mutex);



