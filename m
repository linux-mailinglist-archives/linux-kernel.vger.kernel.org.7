Return-Path: <linux-kernel+bounces-764593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF95B224DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E511A2899C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D6D2ED17F;
	Tue, 12 Aug 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eW78CtEI"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34242ECD26
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995578; cv=none; b=BrDE8gb2w5Gofdh6YvkDFC0ZFbS8E/jsm/PGp/zytPKhCp34tFaR7DMGA3N+9G34WjwfhZ+qmpeuGsJLyMlEcyzPm24RV7zdFarW8hO68v02NVRxAvoYm4nWiv7ZyMF31DYlFyqCCKA9nh2tU5vhbRWgLdfqstTYKxMMrAargk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995578; c=relaxed/simple;
	bh=90A0POUVdjRmDsJdSa06F+cFnSb60quQYA/J8S4zWVM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UHC0lAGJrKXqaSt44i/nEbncHKQqe3+2nMjYL9SYXO95mhoeUkaHZ5u4/cFOs1PwXfsqMKdEFJqCdbZa7mbanEqq9LuBzWLG6JnGrjSMQ6NVgP4h5XeGGtG1mGVo3Lg3k88hGxdA06Wevmh/eZbBfBX7NyJuYcg6xdZpf1kR0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eW78CtEI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=1/lNevcxT2DftRRLAkNmAg/Df1IFy3AMCXEmSlENCKY=; b=eW78CtEI4B01OKRS15fRLKNWqP
	vHNa7u0ZJSoJ8J/f4R7DSioTzoBrRDWId2TH7egNhpBWLqsEFGbaGAYfOmnrZJ5O2ofeoDdNobDQS
	pRF0vG8dE8gMPobL6+Xhi7lEGbsaNz+9Lhm0ab+DYOnRJS/sGYQeeHXkzcqn9yLIxJKSa3OOV1jod
	kHO76NdqrIiZ9z8Fhi4HqTcoV2QrLksoxJAs6vvC32vlUmEr3d8SyqvfvEXtfK89L3r9ePRjtamCu
	bzlnt9mgiKF6qibz+l3P8zLma43jzIT/lIHebLLGrAOZDGl8QtRmdoCi/ziTCeaTG/InpcISMTrUO
	9/zfgJgQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000Fmjx-1n8a;
	Tue, 12 Aug 2025 10:46:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8DAF030049D; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104018.424519320@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:38:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v3 01/15] perf: Remove redundant condition for AUX buffer size
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thomas Gleixner <tglx@linutronix.de>

It is already checked whether the VMA size is the same as
nr_pages * PAGE_SIZE, so later checking both:

      aux_size == vma_size && aux_size == nr_pages * PAGE_SIZE

is redundant. Remove the vma_size check as nr_pages is what is actually
used in the allocation function. That prepares for splitting out the buffer
allocation into seperate functions, so that only nr_pages needs to be
handed in.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lkml.kernel.org/r/20250811070620.389961756@linutronix.de
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



