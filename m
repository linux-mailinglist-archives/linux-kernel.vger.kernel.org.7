Return-Path: <linux-kernel+bounces-762425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5854AB206A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848347B3DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C167265CD8;
	Mon, 11 Aug 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3nlVcLR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8F27603B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909390; cv=none; b=YN0+2T5PNkL7U53f/OhQ6Ex26aswJmCMAXo07rbaot0dgIpNGILKcZymr5NQX+Uo0gw3pv8la7IoGeM/vc062wAOgZ61uutR1+LpQGauC7wvxetZd070/W8d51NjCOUbNQv9250KCBm3XHVBE2IgoYC4ZKO9cq6P34wXgHu8H2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909390; c=relaxed/simple;
	bh=yrg6qpvIoOnSu8dZRTm5TaRdw+rV9X95X+f5IMhGLL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g45Lecl9iDr1Dls2O0zGqMVx6v7tOt18vw0Ep1yH4ytjAhf77R3wRT/1JtI1TfGzd7rvdzV09OXY9/lOpFI8gupwlUBaUo/+nvt90dEGScmtFEYgcnxx8HVFF7szixTcYwAEvBnY2aetTwGJMQC/cNLmS6rNgE6WIR9ue1W3IZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f3nlVcLR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cB8T2Zfy3lEILI02i+RCSVlPO548GyoU8ahKsrlqrng=; b=f3nlVcLRLRvWnuHchY7wsJ4eJ6
	IkeVISTdY4h/mq0j2Wjnjqr03Vg5pLMtqr3dV8NgYdQaxgoRIc1H0GPPF980gF+Waeh9t/MvEsXNK
	iW6VjjGHtKJpEDcBgJUOwsxrt2Zu4PKd0Cnq/Szo+m3gZycjmmUxBkV/tkEd5gFFQSYJjYfra17G9
	3bLYcTsC+phXxGKAuGCmoUsr9PBTMUSm0lNRJnfpHLWpcXBJRM/hL/DHNHZisUVy6GgdRqqTd6D4Q
	EBgrRPJ0p6A8ryNrfWGsd/DQMpmsnJihFpLmf31+wC2otJWgujneu/LKWmyoK06oKHs42KatelWzX
	6zBGbMNg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulQ60-00000004Jud-3SIs;
	Mon, 11 Aug 2025 10:49:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 75761300328; Mon, 11 Aug 2025 12:49:40 +0200 (CEST)
Date: Mon, 11 Aug 2025 12:49:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out mlock limit handling
Message-ID: <20250811104940.GF1613200@noisy.programming.kicks-ass.net>
References: <20250811065859.660930338@linutronix.de>
 <20250811070620.463634790@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811070620.463634790@linutronix.de>

On Mon, Aug 11, 2025 at 09:06:37AM +0200, Thomas Gleixner wrote:
> To prepare for splitting the buffer allocation out into seperate functions
> for the ring buffer and the AUX buffer, split out mlock limit handling into
> a helper function, which can be called from both.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> ---

Does this not also need this? I found this stray user_extra when I
eventually removed the local user_extra variable.


--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6997,8 +6997,6 @@ static int perf_mmap(struct file *file,
 	if (vma_size != PAGE_SIZE * nr_pages)
 		return -EINVAL;
 
-	user_extra = nr_pages;
-
 	mutex_lock(&event->mmap_mutex);
 	ret = -EINVAL;
 

