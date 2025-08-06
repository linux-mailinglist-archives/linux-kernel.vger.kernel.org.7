Return-Path: <linux-kernel+bounces-758291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D41EB1CD49
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C8189BCEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E422BEC2F;
	Wed,  6 Aug 2025 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jR//06CK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GtfCjCIk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63738218851
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511179; cv=none; b=nKIeRUHPdEXBFTs4WScZYuvTh2QAXlgdJXJuFQDzvrxJm6hGq79TiKM9/LB5qqX1D9bYlIXEoUlDjB2lkYUvsqjyX1g10pz9tK8/NXID8UHDmaPpHBCUzMLPMHKRMndZb+w5xb+U1W+zHaN9mFQ0aQjHYeGQYoJtszb2HGC/EqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511179; c=relaxed/simple;
	bh=ezyusppn6TC+HKOYmKP2XK4z1E2hbCIZce901l6bTzk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=o43RmqUxahmvobWnTVMFk/lYJ9iQDdOuSvKuVOoR4iO0Ki8m5hyebj6RxmTA5b3dfeiwo79fDNr30kQm/fspLmyn6d5L65WtnwafTAAWk3Xh6GwOTAK5X8ivQV8SRpHO6M62jYQTHD51Qg2l7jQCJE4ljHkEY3i9XHhhwOJQjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jR//06CK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GtfCjCIk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250806200617.258754928@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754511174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xtCc47izxKFF4G1h9XrAXBPLX8fBReX2herfs+JeM0A=;
	b=jR//06CKnmW1mmlrDIUAdr5S42M0JlttdXpNhXWrnQ7dnpDZ7RoeXFL0Qbq7ALukRxP++i
	RYqU97fXaxH7i4DFNQIM4Le/nsO8QlDTdCLnZx7lJJAa6dU5VtHm9wcCSvFhAYl8T+J/Ys
	OLe5Wb+mkWY5fTNM9tGDdlY4onjC7apKMNY4XgXOlrRB5hkdzSrFrW11FwF8kTDfCsn+Vp
	j7AyuiV6BSQD6/jDVV2KGq00cBBItzroxbprpahsrY+mO8mny/bhm1dkR8dytcSStwYmN2
	KJjwI0r4ZcoVc/oAwWwaeP0CljMKK7scg8oKg1k9VA/1OMJeGT+wgonRm6AVCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754511174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xtCc47izxKFF4G1h9XrAXBPLX8fBReX2herfs+JeM0A=;
	b=GtfCjCIkzB+YHk//9Z3OSgPBPGCVPlM+yQBQplq6xek3xpfnKCxF3tMyWfJUL3uMAIn6YD
	PlJi7Kp8uEGviFDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch 1/6] perf/core: Remove redundant condition for AUX buffer size
References: <20250806195624.880096284@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed,  6 Aug 2025 22:12:54 +0200 (CEST)

It is already checked whether the VMA size is the same as
nr_pages * PAGE_SIZE, so later checking both:

      aux_size == vma_size && aux_size == nr_pages * PAGE_SIZE

is redundant. Remove the vma_size check as nr_pages is what is actually
used in the allocation function. That prepares for splitting out the buffer
allocation into seperate functions, so that only nr_pages needs to be
handed in.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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


