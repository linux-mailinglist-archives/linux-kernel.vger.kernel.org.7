Return-Path: <linux-kernel+bounces-764579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10915B224D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C9A177B62
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0E92EBDF3;
	Tue, 12 Aug 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IrlMrvZt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E22EBBBC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995575; cv=none; b=RcLK9CF/mp+OeISAqzm6fwrswmwzHDJsl4zjglltQtaNaPVJwj99v/IeV0Iknsj/BuVFW0jZVq962IDq1WsU4E1xaLtW3LzHBX1mD/Oz9fMjVkElPLFOYbjyjrHiEEpzcnqcGUg7WfX2fBGnhXLA15yPYFDH3H6Z5dGiwe+lWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995575; c=relaxed/simple;
	bh=huIGDtcKlRxAlBFW57UooF8d92AXgxH92M8j0MQ6Yo4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=l0POEbCuC/f6PJ+Kq/5IY+9vHGTm943jrBXlp81Kt33aouwKUED4tyRiCm6EnXsU2iZRJJETHu2YVIIaedewKY4j6DiGxrEYRyU4I9ZCgCwvlZZOmRMfb6GK1Di2zD4UVIcUwCW5ABn5tp0WCoPgJUZrZWufHlLxQxrPcvy0Ono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IrlMrvZt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=vWI8sEWp8on09JLJtm1IzmG6jE0fexrCizV9pTCnHgg=; b=IrlMrvZtpYP3SL0RCR8SHq1EFP
	TqoaPsLp43RaOgTk+Bjnta/E08ZcEhRwiYfrtwoRMkocXZlG/J9iFU7js2nNOzLRCA7OxNyuA9Eif
	0Qmcb20fzSOVmq1x0QIpmbj7uYTZPqjvwaLNGyMmmDgU2QM+aB3MmoMneFB35PcF8e/kcrSLzTOSR
	HBZ8imjgMkBBGCQKrKR7lTirEVr+xPYK2bVus5r3HbHhtGMJlUSFEphKEPjUsBGPx6+0zJ//2sNqz
	TPyg6tYGMbUgEERMlXPcmDQE8m5tNth18/ahUSkZBcHqCUztXnYM1IShExLCr4gtm3SwqyCiEIicK
	IMZCeJMQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmWA-0000000FQZC-1o3b;
	Tue, 12 Aug 2025 10:46:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id AA887302D9C; Tue, 12 Aug 2025 12:46:09 +0200 (CEST)
Message-ID: <20250812104019.246250452@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 12 Aug 2025 12:39:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 torvalds@linuxfoundation.org,
 mingo@kernel.org,
 namhyung@kernel.org,
 acme@redhat.com,
 kees@kernel.org
Subject: [PATCH v3 08/15] perf: Use guard() for aux_mutex in perf_mmap()
References: <20250812103858.234850285@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

After duplicating the common code into the rb/aux branches is it
possible to use a simple guard() for the aux_mutex. Making the aux
branch self-contained.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6975,7 +6975,6 @@ static int perf_mmap(struct file *file,
 	struct perf_event *event = file->private_data;
 	unsigned long vma_size, nr_pages;
 	long user_extra = 0, extra = 0;
-	struct mutex *aux_mutex = NULL;
 	struct perf_buffer *rb = NULL;
 	int ret, flags = 0;
 	mapped_f mapped;
@@ -7098,8 +7097,7 @@ static int perf_mmap(struct file *file,
 		if (!rb)
 			goto unlock;
 
-		aux_mutex = &rb->aux_mutex;
-		mutex_lock(aux_mutex);
+		guard(mutex)(&rb->aux_mutex);
 
 		aux_offset = READ_ONCE(rb->user_page->aux_offset);
 		aux_size = READ_ONCE(rb->user_page->aux_size);
@@ -7159,8 +7157,6 @@ static int perf_mmap(struct file *file,
 	}
 
 unlock:
-	if (aux_mutex)
-		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
 
 	if (ret)



