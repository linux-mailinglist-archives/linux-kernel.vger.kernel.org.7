Return-Path: <linux-kernel+bounces-761914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CBB1FFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F192616DA06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67EB2D949C;
	Mon, 11 Aug 2025 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3W1NOeG+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0vtACisv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F6279334
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895999; cv=none; b=R6xOPAAdrOvB2182j69agXMMlleCBXiLL6r4F6D15y027KQCcrZgvD1iSh2DJEyhRdshYf0/ZjejB7oj67Ub7VC/YZj/qSaXVfP/rtbyMPNIjsrDeBMH150tLUO0XB75Z1kZWtVDWUjheLm8OgGxFsnBYL6f2xoTW2oMHvKJykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895999; c=relaxed/simple;
	bh=hfqzaLC5FXLokd5X8odIAicrYgBqkvZyyI+amuNmknM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dtF1R2HtCDYHbNlEitfeuU9FUXiK+TTsFpaSvNI8tSb+5Nu1bNdTXpKfZHO2kSHh+iex3N4KRtwfypM8sDE+NrvzRz6zbWTRoj/B3tHY4sA/yCWHw+eiApvHTEd0CotWfGNxF4e9Eko+go7zpMN5By6hnWl9KC2txVbKglc/kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3W1NOeG+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0vtACisv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250811070620.389961756@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754895996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Fe93kPysVc0681bQkvTI1QmaU9Fb+yjE795s7MX9W7s=;
	b=3W1NOeG+r2Rdto9BRGXiHOsMcnblkftRZoKCVjQHL98JWtVnYxER/9iwsTjkF549e9ju0j
	eTbX1R1InG/pXanacit+OB2cVJU3yixNuTsIUOKbl09xyMJVJiLLQxuIs2xpa05qJ8MZRj
	U08QtC+QPlrhf8+lB99T5rPPHq115OktrfOb0xK4pQwfbu6ZTKSXnVJuPE6QYPMEOVTfc4
	5/dxUjL+CCQMMGVlHIzQDhuRlVByQaa6eJ8cOejYYx6FqCsNltTBZcINh+t8ugTcgZeCLq
	l1uRMFX6YhI5TTgPYqbtfvY6OxM1PNR6azaamaYyxbKPWp33N4P5kwYeedcn9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754895996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Fe93kPysVc0681bQkvTI1QmaU9Fb+yjE795s7MX9W7s=;
	b=0vtACisviFuAYsbFCehbIm8YZFQLmc6+WnwY7qOpY4QX+Wrt9KRAxFP3+j7su3+2TrOCFG
	17c329/veuxkbNDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch V2 m@/6] perf/core: Remove redundant condition for AUX buffer
 size
References: <20250811065859.660930338@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 09:06:35 +0200 (CEST)

It is already checked whether the VMA size is the same as
nr_pages * PAGE_SIZE, so later checking both:

      aux_size == vma_size && aux_size == nr_pages * PAGE_SIZE

is redundant. Remove the vma_size check as nr_pages is what is actually
used in the allocation function. That prepares for splitting out the buffer
allocation into seperate functions, so that only nr_pages needs to be
handed in.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

---
 kernel/events/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7043,7 +7043,7 @@ static int perf_mmap(struct file *file,
 		if (rb_has_aux(rb) && rb->aux_pgoff != vma->vm_pgoff)
 			goto aux_unlock;
 
-		if (aux_size != vma_size || aux_size != nr_pages * PAGE_SIZE)
+		if (aux_size != nr_pages * PAGE_SIZE)
 			goto aux_unlock;
 
 		/* already mapped with a different size */




