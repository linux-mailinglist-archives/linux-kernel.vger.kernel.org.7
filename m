Return-Path: <linux-kernel+bounces-764588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A022BB224DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AC02A1F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA342ED163;
	Tue, 12 Aug 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I6+ssZgd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B322EBDD3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995576; cv=none; b=F6tQMB4KMdtE9q3aoQVtO7gj5xhFe7wEDJz/AuF0SadNrd7gLDNxJD1naxMZsKyjuHSz3led4HSC0cNtvkG+n2ValOu7stk5WFCxdkE6gw9bmp/+leyAAEhmbj5qifqmOoCRt4JV+HyQJqn7iiivq2wGvyyI9LpLeAU7fEWtMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995576; c=relaxed/simple;
	bh=9dBKkxgVCaJlHroMXQ5F48AOP2I7LQc+qPDdhwLvAe8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ko6RDWD14NVYg8KD/Rmcwi7IjZY8uCbaszwjZl9Ad8GmY7HzsqH6qsf8j/IZ/7krrCigCczlUR9c83pKQudZZfGYtRosPG2+ygOWOUQZmUydhWjftMItq5kG+lBGON0m/TyGa7LnIugL7/FPoxk6+f/Y8LXV6PFBHR2oGs7V8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I6+ssZgd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Hpirb6bCQAZ5IpK55f3SQ1KgVjNuGOPebF5RQWmGUGE=; b=I6+ssZgdFJlAS1khGRuQaaZ2YK
	Wb4XpWlOoZEliyRajphSdT+U0hyyqJKUzKiHh9Y4v/as8b7OjgNF2RwEZbKx2ZE99IJYz2VRPHjWj
	xM7lDbJPcgPbr1YsahCm9dXeqvuo+sellOaVqoZDEzaME9VKdB2VPOJ00c8IK/ffySHFSWyG9Vote
	JHiuG0Mkk0M2tRhLWU2XARxsddNA7ommOZ06V6l7zLlnOsVGNh1rmN7rUHdmfGhBWjPXdNyaidONa
	bveea0Fo5qy0Vus0xtz11iQpOUpQDIz4v3x2nmBEGx3Q8nNvCtUtCJ0ixg5VHtbD2Z52W2ynvLskz
	yTuhsDpQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWB-0000000Fmk9-1mNf;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id AE653302DA9; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.362581570@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 09/15] perf: Reflow to get rid of aux_success label
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Mostly re-indent noise needed to get rid of that label.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7127,30 +7127,29 @@ static int perf_mmap(struct file *file,
 		if (rb_has_aux(rb)) {
 			atomic_inc(&rb->aux_mmap_count);
 			ret = 0;
-			goto aux_success;
-		}
 
-		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-			ret = -EPERM;
-			atomic_dec(&rb->mmap_count);
-			goto unlock;
-		}
+		} else {
+			if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+				ret = -EPERM;
+				atomic_dec(&rb->mmap_count);
+				goto unlock;
+			}
 
-		WARN_ON(!rb && event->rb);
+			WARN_ON(!rb && event->rb);
 
-		if (vma->vm_flags & VM_WRITE)
-			flags |= RING_BUFFER_WRITABLE;
+			if (vma->vm_flags & VM_WRITE)
+				flags |= RING_BUFFER_WRITABLE;
 
-		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
-				   event->attr.aux_watermark, flags);
-		if (ret) {
-			atomic_dec(&rb->mmap_count);
-			goto unlock;
-		}
+			ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
+					   event->attr.aux_watermark, flags);
+			if (ret) {
+				atomic_dec(&rb->mmap_count);
+				goto unlock;
+			}
 
-		atomic_set(&rb->aux_mmap_count, 1);
-		rb->aux_mmap_locked = extra;
-aux_success:
+			atomic_set(&rb->aux_mmap_count, 1);
+			rb->aux_mmap_locked = extra;
+		}
 		perf_mmap_account(vma, user_extra, extra);
 		atomic_inc(&event->mmap_count);
 	}



