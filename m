Return-Path: <linux-kernel+bounces-764583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C32B224D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DE83ABEED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD952ECD13;
	Tue, 12 Aug 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CF42ILGa"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4482EBDC1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995575; cv=none; b=akduSGqKv++XXAovp385QBVoLefhE6R7f7ni8GyHPPjRL2FDBrwBLCcWvLpV+vap1MbcbQmUnxFyzeoIhyzCWDfyLOule+kKZbG7jp8iWFRKa6VXd1VprLyE5chED+XgiKoYCjCBA7gBY2fPr/IcITiFzbHd6wMCncMgeLGp8nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995575; c=relaxed/simple;
	bh=ZE5vynBKnwKYuQNYC3nwGNGwXONkUv7/Rbu9iVfkjz4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=daRz4APe+6Qp9FOAh6CfgBbICAg8i+1J8SXpiqIIhOhCXxQK2kKVq6TEY8j81oOwZsk9leZECfP3g2HmlwVJiNQ3Y2zrqdJKmUt9pFf9uN1ewj3kmmXVhE2plevaP4SaRg2lXG2Ox8rLbmPMyxyZbgkgcDMvupmEP5tDN85U4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CF42ILGa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=MpOltfKavXG/lOsVZUtZqsNzyjSMLe7nbHwuyWd1j9Y=; b=CF42ILGatp97EQ0oy837nlljBU
	iAgvSCk0z2/810HmRa+lUmpd35wbDof9xwGKbPmY171ILGbKlmvwkLWH2ZoASs25akdNQYEvSE01P
	JfjJn1keK9bJSqv/5pVSNd8unb1r4kI7AVVJrWNXq7g6/eOxv+mIs76xVqH6N6gxVJ9ZPjMdIkv+9
	iER9UjsOxNc2N61csSgsrRHUNKISi/IFeBSlxhb7/Xs0Vq0i9I3gP8aq9s/BcK3orj4orjWGgNHWJ
	nxUdeSjYxZ9LBYl4f0FLfp9HobFvGvSmY/eJ5EbXw+wLmtgwDuh7aCjJB/Hli9nLcnagOMU0YtnnV
	Xe9KVZ/w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000FQZQ-3Sec;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B290F302DFC; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.494205648@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 10/15] perf: Split out the AUX buffer allocation
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Move the AUX buffer allocation branch into its own function.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |  144 +++++++++++++++++++++++++++------------------------
 1 file changed, 77 insertions(+), 67 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6970,6 +6970,82 @@ static void perf_mmap_account(struct vm_
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
+static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
+			 unsigned long nr_pages)
+{
+	long extra = 0, user_extra = nr_pages;
+	u64 aux_offset, aux_size;
+	struct perf_buffer *rb;
+	int ret, rb_flags = 0;
+
+	rb = event->rb;
+	if (!rb)
+		return -EINVAL;
+
+	guard(mutex)(&rb->aux_mutex);
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
+	/* already mapped with a different offset */
+	if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
+		return -EINVAL;
+
+	if (aux_size != nr_pages * PAGE_SIZE)
+		return -EINVAL;
+
+	/* already mapped with a different size */
+	if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
+		return -EINVAL;
+
+	if (!is_power_of_2(nr_pages))
+		return -EINVAL;
+
+	if (!atomic_inc_not_zero(&rb->mmap_count))
+		return -EINVAL;
+
+	if (rb_has_aux(rb)) {
+		atomic_inc(&rb->aux_mmap_count);
+
+	} else {
+		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+			atomic_dec(&rb->mmap_count);
+			return -EPERM;
+		}
+
+		WARN_ON(!rb && event->rb);
+
+		if (vma->vm_flags & VM_WRITE)
+			rb_flags |= RING_BUFFER_WRITABLE;
+
+		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
+				   event->attr.aux_watermark, rb_flags);
+		if (ret) {
+			atomic_dec(&rb->mmap_count);
+			return ret;
+		}
+
+		atomic_set(&rb->aux_mmap_count, 1);
+		rb->aux_mmap_locked = extra;
+	}
+
+	perf_mmap_account(vma, user_extra, extra);
+	atomic_inc(&event->mmap_count);
+
+	return 0;
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event = file->private_data;
@@ -7087,73 +7163,7 @@ static int perf_mmap(struct file *file,
 		perf_mmap_account(vma, user_extra, extra);
 		atomic_inc(&event->mmap_count);
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
-			goto unlock;
-
-		guard(mutex)(&rb->aux_mutex);
-
-		aux_offset = READ_ONCE(rb->user_page->aux_offset);
-		aux_size = READ_ONCE(rb->user_page->aux_size);
-
-		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
-			goto unlock;
-
-		if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
-			goto unlock;
-
-		/* already mapped with a different offset */
-		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
-			goto unlock;
-
-		if (aux_size != nr_pages * PAGE_SIZE)
-			goto unlock;
-
-		/* already mapped with a different size */
-		if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
-			goto unlock;
-
-		if (!is_power_of_2(nr_pages))
-			goto unlock;
-
-		if (!atomic_inc_not_zero(&rb->mmap_count))
-			goto unlock;
-
-		if (rb_has_aux(rb)) {
-			atomic_inc(&rb->aux_mmap_count);
-			ret = 0;
-
-		} else {
-			if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-				ret = -EPERM;
-				atomic_dec(&rb->mmap_count);
-				goto unlock;
-			}
-
-			WARN_ON(!rb && event->rb);
-
-			if (vma->vm_flags & VM_WRITE)
-				flags |= RING_BUFFER_WRITABLE;
-
-			ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
-					   event->attr.aux_watermark, flags);
-			if (ret) {
-				atomic_dec(&rb->mmap_count);
-				goto unlock;
-			}
-
-			atomic_set(&rb->aux_mmap_count, 1);
-			rb->aux_mmap_locked = extra;
-		}
-		perf_mmap_account(vma, user_extra, extra);
-		atomic_inc(&event->mmap_count);
+		ret = perf_mmap_aux(vma, event, nr_pages);
 	}
 
 unlock:



