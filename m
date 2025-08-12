Return-Path: <linux-kernel+bounces-764584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE54B224D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266061A28B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACC42ED151;
	Tue, 12 Aug 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erqaHiiR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25F2EBBBB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995575; cv=none; b=rDfEO6lFoEommfZyqMLOlj4HWpjnaYRMgnZ6JxXOiAi0O24VU6K2hS7KWrQHugV5o8hzRoand9Ljq4y+nVDEc77oRzJjdTnHCR+j3i9K/heFWLQyNcRXn/qT2YOxZGtgcCvkm3F+g8cnebuBJeojKQiBlgWvmNzR2e4vhJPZ6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995575; c=relaxed/simple;
	bh=+GqHX87jWLZqw+t0UZth4U8Z3fRwn4VwUt00AcsKB+g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K8l1D7HGr8uBYrw6OTY+hBzNB3LxSGkIJjlmAlWbfr7cvnknxZl8NFDdoUhswSJIQQ8E1dgSDlZkEgrEEYJ7lUlnLxr6/Hws8rBjzo0EVGaPZECYIs6gdue6/nocg710hGOENLj1Qzg6kj7Rod5BxyeA1X4s1j3klWfBqu1Wkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=erqaHiiR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Tnj+ZpbznC9f7uV46Bm+bU4G2ZhL0fK09wKDx1V/NPg=; b=erqaHiiRIFeTNzrEiadSKD0O7d
	wqjwyqwaiwIw0CJ3Of0PBa+9OPXLY7fEeoj32LdeoqChz6P9zraloS1e0ARcemSAzvrZBosIkKBrN
	hSS1PD74hFE2EHn5Ms3l0r9/BR65MkGKFLwqbY/OYyiaIV1iV3irsrpHZ6jwGlfxvkVwr1UTiVcl5
	eZ4MSITOhzhLlbeYjaTUAtaoWvVgfsp4UF9ZNnpBAzWMATx6exZhqlpyAUmMRg10smnuRRZ3+lV+n
	X5Y7a4PtU7qNfmIRmIAS5XC81r02HwBp2pA+6Q+BFML9Sg7XH4NHZKVyEa1M2UiwJKdwlBMxp/+u2
	INvvx47A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmW9-0000000FQYg-3VrD;
	Tue, 12 Aug 2025 10:46:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9A83A300583; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104018.781244099@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 04/15] perf: Move perf_mmap_calc_limits() into both rb and aux branches
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
 kernel/events/core.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7054,6 +7054,16 @@ static int perf_mmap(struct file *file,
 			ring_buffer_attach(event, NULL);
 		}
 
+		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+			ret = -EPERM;
+			goto unlock;
+		}
+
+		WARN_ON(!rb && event->rb);
+
+		if (vma->vm_flags & VM_WRITE)
+			flags |= RING_BUFFER_WRITABLE;
+
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
@@ -7100,17 +7110,17 @@ static int perf_mmap(struct file *file,
 			ret = 0;
 			goto unlock;
 		}
-	}
 
-	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-		ret = -EPERM;
-		goto unlock;
-	}
+		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+			ret = -EPERM;
+			goto unlock;
+		}
 
-	WARN_ON(!rb && event->rb);
+		WARN_ON(!rb && event->rb);
 
-	if (vma->vm_flags & VM_WRITE)
-		flags |= RING_BUFFER_WRITABLE;
+		if (vma->vm_flags & VM_WRITE)
+			flags |= RING_BUFFER_WRITABLE;
+	}
 
 	if (!rb) {
 		rb = rb_alloc(nr_pages,



