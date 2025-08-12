Return-Path: <linux-kernel+bounces-764581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15490B224D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5231A28839
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7752ECD00;
	Tue, 12 Aug 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r/36OG1P"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3542EBBBE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995575; cv=none; b=OXkijRafH93LplX01aqVzi7TXhkEIvm0thJMmrPShhOp3fA5CL+/piet1Y136Qiw1MjVOAJ5g3phFN2jMyt6MIZJWqaQ4lHjkL2HtutsXinwY1FBO7FFoc+GbCD+U2ovzHZQ9mpT2hkdsrZzJSrM+fmrPQko3tENQLH35mZoZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995575; c=relaxed/simple;
	bh=2ba7Z58vhrDfj/ZlafZhaiDTlHwpRGpfmw/dwXTdt24=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jstUIulMd1/3LeNRDauaoXOj/UkRBlhIouQesIp7JgnD1MRhrCnKZLsPeblUOFMS7ArsdrNdRK0CP8mIc2in+56uxqKN+JiXgtD/+59+g9oyJDjXJ+TO6BaYvuUjry3jG7A2pScxIlCKsho/KxEpiEHogp3IsFawmQ4S/Cq7sQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r/36OG1P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ScUPih1zGAlOszyxaH0LrklvJs+SRhmKJ96YIxT4pFQ=; b=r/36OG1P9f57MsYKXNG1BAbjST
	4wfVGE5iR+CDKP3B8umTY32VEMuPzk0/0j+NVV7DM6ypZYuOp0RmEin1iwTGavK5Tg4JYm9l3BvBf
	CR2Xlc7mEUBWsIFuPKIYSkGQ96JWnZUVmcjKjMeEystnQNnvzmCXCDTUY3Y8vXzlYA9ag0PIasvI0
	amCvYZjz6cdqY1+lQgah6QKgjhuRol2jMJymRRV7kIYt4DSnXpk7LkFoS5RF+Z2ECy3zOJvE33nds
	WBoarcI9OEL/eW/4pP1G5CBhLGuPWkrtANP7ce0qGJQA5B22wJ/7CdAPZf3+pwI8MSyESRYIdW5kO
	YD9fC3uA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000FQZB-1mSO;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A23AA300B53; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.016252852@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 06/15] perf: Move common code into both rb and aux branches
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
  C;

into

  if (cond) {
    A;
    C;
  } else {
    B;
    C;
  }

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7043,6 +7043,8 @@ static int perf_mmap(struct file *file,
 				ret = 0;
 				/* We need the rb to map pages. */
 				rb = event->rb;
+				perf_mmap_account(vma, user_extra, extra);
+				atomic_inc(&event->mmap_count);
 				goto unlock;
 			}
 
@@ -7083,6 +7085,9 @@ static int perf_mmap(struct file *file,
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 		ret = 0;
+
+		perf_mmap_account(vma, user_extra, extra);
+		atomic_inc(&event->mmap_count);
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
@@ -7127,11 +7132,12 @@ static int perf_mmap(struct file *file,
 		if (rb_has_aux(rb)) {
 			atomic_inc(&rb->aux_mmap_count);
 			ret = 0;
-			goto unlock;
+			goto aux_success;
 		}
 
 		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
 			ret = -EPERM;
+			atomic_dec(&rb->mmap_count);
 			goto unlock;
 		}
 
@@ -7142,20 +7148,19 @@ static int perf_mmap(struct file *file,
 
 		ret = rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 				   event->attr.aux_watermark, flags);
-		if (!ret) {
-			atomic_set(&rb->aux_mmap_count, 1);
-			rb->aux_mmap_locked = extra;
+		if (ret) {
+			atomic_dec(&rb->mmap_count);
+			goto unlock;
 		}
-	}
 
-unlock:
-	if (!ret) {
+		atomic_set(&rb->aux_mmap_count, 1);
+		rb->aux_mmap_locked = extra;
+aux_success:
 		perf_mmap_account(vma, user_extra, extra);
 		atomic_inc(&event->mmap_count);
-	} else if (rb) {
-		/* AUX allocation failed */
-		atomic_dec(&rb->mmap_count);
 	}
+
+unlock:
 aux_unlock:
 	if (aux_mutex)
 		mutex_unlock(aux_mutex);



