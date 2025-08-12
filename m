Return-Path: <linux-kernel+bounces-764589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE7B224DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1AA3B7276
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6662ED175;
	Tue, 12 Aug 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNx85/um"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1822E7658
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995576; cv=none; b=vGGhRF+egvzII/BeNoyEPBeb+Gvbh96TL/EoAEIapapkHgPdoNc+HvRkSIN6O8fNV/EWAaiYERTAvINMQByozkW08s2hSajHpnKk1sj9JgZ2vV9fuxbhicyNjkD1XDvSWWiq/owxdsHDTZkbXma434gRsr888j+YEYAtFWJ9VpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995576; c=relaxed/simple;
	bh=6jXnp2rS7TSHsIuoRZxdD2f8WwXiq1oxKEXJqcaElw8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tTR3HhUyKCCraBlbJ9zYvGu5epkTFZhnzrQ0+ktb3yuzBK/qa4O/kue54WuazJN34pJxqJLy/fdwbs8xImav40yFyB0FawoLLTDNFxD7CXMsnbeYZ+2j7b5xaVdGlBmWHqUC/wl5VJzJVoOwYlp4u5CJRmDx/xZvvlgASsCo0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VNx85/um; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=fJdG7PKCgL19h78JrV/TWKTJ1AopejIhDsc/rZOBL8E=; b=VNx85/umE5XxKIS0zpGhghKEVk
	q2sFaHPk+NRP8FTzScZQUM0F2WwWwbXbF2nYHVXHDIJ1ifa3Y/a24lupoLB3IIwapybYIkkRSBlEf
	DL6SbRhV+bT/g/pb8Rf95XJ5pZD43WX/rNpq7n3vDn+ZQCzi1b5u2HdLAvs8fUdXYr9PDR9MsRM15
	p5wzvQfsPKvtlYvlfqc1KxaA095kvo3E/pa8e1frEjlwLRS9Ybksp50v84NTXBHOqaG8A8/HLbv0f
	soQwXifQeJbAwldqWHfNgIKcOsa+u6gd45M3/sAOpadQuIXqInEBKuxU5CLPK3JxdJIg/M7cLh4EE
	NWoCw09w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000FQZ9-1jPe;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9E6EB300708; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104018.900078502@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 05/15] perf: Merge consecutive conditionals in perf_mmap()
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

  if (cond) {
    A;
  } else {
    B;
  }

  if (cond) {
    C;
  } else {
    D;
  }

into:

  if (cond) {
    A;
    C;
  } else {
    B;
    D;
  }

Notably the conditions are not identical in form, but are equivalent.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7064,6 +7064,25 @@ static int perf_mmap(struct file *file,
 		if (vma->vm_flags & VM_WRITE)
 			flags |= RING_BUFFER_WRITABLE;
 
+		rb = rb_alloc(nr_pages,
+			      event->attr.watermark ? event->attr.wakeup_watermark : 0,
+			      event->cpu, flags);
+
+		if (!rb) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+
+		atomic_set(&rb->mmap_count, 1);
+		rb->mmap_user = get_current_user();
+		rb->mmap_locked = extra;
+
+		ring_buffer_attach(event, rb);
+
+		perf_event_update_time(event);
+		perf_event_init_userpage(event);
+		perf_event_update_userpage(event);
+		ret = 0;
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
@@ -7120,29 +7139,7 @@ static int perf_mmap(struct file *file,
 
 		if (vma->vm_flags & VM_WRITE)
 			flags |= RING_BUFFER_WRITABLE;
-	}
 
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
-	} else {
 		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 				   event->attr.aux_watermark, flags);
 		if (!ret) {



