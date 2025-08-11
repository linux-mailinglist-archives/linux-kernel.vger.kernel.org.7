Return-Path: <linux-kernel+bounces-762603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E7AB208DC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A9018A2DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14222BE63F;
	Mon, 11 Aug 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jA9tZdAD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZi06+VF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD3DF6C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915793; cv=none; b=BFXcBCgT3T5yn30bpqmkTeIYLIi1tH6LgssWP+/LLp17DMyP6pahCwPJ5oV9r6NmOtqzTM5UjVNIkbbHfI+Az8NzGny3jSQqkab8ea1+bzRxDfDSrNfCxThQ5irktANPTqInZXFP19xnm51B6rCGSXpbBDbfXnr+Qfpjwq4AOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915793; c=relaxed/simple;
	bh=hfqzaLC5FXLokd5X8odIAicrYgBqkvZyyI+amuNmknM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tSeCcb9NTbVDnY11MypXlpyzEewH+ig2gzddQUqp0YivfqfswP0Klj09hI+2IQAmOcAwCTD+QpzyFVBwrTEITCGo1fpGa3mBvI4/azmTR8ciLwBn4/k0o49nYMIlUUK+Q9oaMvJiKyWLUTwkUzIMgE3reuXozSnQxpKYvt3tTGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jA9tZdAD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZi06+VF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250811123609.476196370@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754915789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Fe93kPysVc0681bQkvTI1QmaU9Fb+yjE795s7MX9W7s=;
	b=jA9tZdADVk0KXNtHTDydgUAYer6VKaQyV0pHi8Bdso7OYN9ID5W9lfibM15HYpfBFzxyyN
	S4EaDJwaP8BFmOz5iiH23cklCkRaixtL0zxGcq4mdMDRvOZnONXUbDBFVEhXVPFpeAELP2
	UlqrE7NpSBj2bkw17ylgfdMklPfRfDPg7XfuKVDh9rMaUsLJi/9nMu55QkSRMHXM6g5Rjr
	NAo8TS8wP/GoZPaBxWIvAvQPIEn+9TtIJIz7CJqS6onhr0h9xlZ38n3mOTDCpX+nq0ENtX
	7cTwQ3t4GLe2/lzAbuUBParYCODVUySSfS1Mvd56bS4qexF55/h6RgljUzHCcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754915789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Fe93kPysVc0681bQkvTI1QmaU9Fb+yjE795s7MX9W7s=;
	b=iZi06+VF3vt0/phEjlsnxGIHVCCNdJqtur9MoQc3U3crj1dLnl8hgC03SjNJnNV9wluL6P
	cFFqmcxeKn3ZAbCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Kees Cook <kees@kernel.org>
Subject: [patch V2 RESEND 1/6] perf/core: Remove redundant condition for AUX
 buffer size
References: <20250811123458.050061356@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 14:36:28 +0200 (CEST)

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




