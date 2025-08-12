Return-Path: <linux-kernel+bounces-764580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB31B224D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A631A287A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2632EBDF8;
	Tue, 12 Aug 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BG4vIY2H"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D62EBBBF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995575; cv=none; b=HuO+djXBo0jB3nkfc6xHkr7zopc78aNixWlXBD3uba0/by7wIkdX8gr2AwVmfv1Q58rQx++6CwAs8cMn52nRY/UT5UNNBpXmz5R+4x2IBW+sE6qvhDTAi/CoL/wVORp117WCNPSAonRLfPcOxkI0eT+EWkZaIrtWwvdPDYj0QTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995575; c=relaxed/simple;
	bh=zK7o3HDuWU4BVKW+6lCrUa9WEjTn4oLRiZkoVTcXZOE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YZOlj7o+op6pdbaUqXVm3fNfx0Z95JmdGlu4ffRVX3HkJkU75d1wyYa7n/lu6wV5uIYvtilTQXm+eb9PQt3aK3FMlHU3JQYAmIEQksnFU4sGKg56CpqTLNmwrGCXtT0ryOFQz0/MAQ8MulnoFmcjmfM8iEbC3jIcGGFMy4ihb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BG4vIY2H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=PNZWAaiFwlYCPNM+xWarlBc9Xsa7ubjKBBskZjPIoTY=; b=BG4vIY2HxeHmMgzal0LZtHl0ta
	JG89u2/wFNUmXK6WswQHPmNqre6ToOmpY6uxUliY7GAeizKluiLqvoC4lTNwPMj9UYiNBpPBmhhkd
	indgbpvieVReJr8/TnfmOC3nixRmr0R6tZPSbwBpyDchtL6VWE8h/g2lwe0tlKnev+4F2x8hUUN/X
	vf7NPbOlFeGos29m0+dq+AFeaSJ6DIx8eXYgTd2F3IKwu6MfBKkvgcD/gXzdY2TX5zEej5nct314Y
	OeCd/64VMzhOk2wfXmapg0FNFyAq5rjTuVbN3JlHiP/5ou/tJyrZSH35HPBWxa+o1vIrU6sxTU5Rd
	7dWTNs2Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000FQZA-1koU;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A6CC83018AA; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.131293512@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 07/15] perf: Remove redundant aux_unlock label
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

unlock and aux_unlock are now identical, remove the aux_unlock one.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7095,7 +7095,7 @@ static int perf_mmap(struct file *file,
 
 		rb = event->rb;
 		if (!rb)
-			goto aux_unlock;
+			goto unlock;
 
 		aux_mutex = &rb->aux_mutex;
 		mutex_lock(aux_mutex);
@@ -7104,27 +7104,27 @@ static int perf_mmap(struct file *file,
 		aux_size = READ_ONCE(rb->user_page->aux_size);
 
 		if (aux_offset < perf_data_size(rb) + PAGE_SIZE)
-			goto aux_unlock;
+			goto unlock;
 
 		if (aux_offset != vma->vm_pgoff << PAGE_SHIFT)
-			goto aux_unlock;
+			goto unlock;
 
 		/* already mapped with a different offset */
 		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
-			goto aux_unlock;
+			goto unlock;
 
 		if (aux_size != nr_pages * PAGE_SIZE)
-			goto aux_unlock;
+			goto unlock;
 
 		/* already mapped with a different size */
 		if (rb_has_aux(rb) && rb->aux_nr_pages != nr_pages)
-			goto aux_unlock;
+			goto unlock;
 
 		if (!is_power_of_2(nr_pages))
-			goto aux_unlock;
+			goto unlock;
 
 		if (!atomic_inc_not_zero(&rb->mmap_count))
-			goto aux_unlock;
+			goto unlock;
 
 		if (rb_has_aux(rb)) {
 			atomic_inc(&rb->aux_mmap_count);
@@ -7158,7 +7158,6 @@ static int perf_mmap(struct file *file,
 	}
 
 unlock:
-aux_unlock:
 	if (aux_mutex)
 		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);



