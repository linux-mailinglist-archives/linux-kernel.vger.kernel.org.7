Return-Path: <linux-kernel+bounces-845460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C897BC5075
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E034188B8CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AC428488A;
	Wed,  8 Oct 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rhgzx+IC"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D4D284884
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928122; cv=none; b=miSsm4QjgZqf3hBzNP4um1X34ONbSTRqX/MY6jIRozlgu4zpvUb0GsCnXVo3HLqDXRCzYi7JbI/C1bf/tQeQOoxWCRZ8CtdkI7x8IaUVzMvWgiXmagx52Z6pUX2YXyT6BUwz9S3gHhaGfT1s0pxmy9A5tV/G2RW64dAVtYA2SD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928122; c=relaxed/simple;
	bh=Zn4K2VDfxQjdtMePzhXHGGcoZoCed8zNFgBVKMC/Tic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5Dt+iEdd7NiLbSuNtsO5merzwRt4dQRGf3DhKKu1iO4CoS8hjfq/Upy3QNLnhuvlfI576C5tbTld74nGIAmeX46CV1LGL/BAFfO0dAK7VsCcEWB4/rUy2uLYZ6TDG8a3VzjvwwVKbO26km0t4bqrKmfALu0YzhlZ9zN6DC1azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rhgzx+IC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xaJ8r93kxW2ilCp+pdPnf+jgQJO/h1G4FxZx0FSfbB0=; b=Rhgzx+ICtTAZhl4O6v/i56Qhwf
	rdG/Cb+Ury3nJVLClI5k8WNVlxcw5749jaF71cw4uO9kkniSNiMOizle1W7h6H07oNGJYheQfR/Lj
	HaEl/uF7vBNjH0jn/1UEOjB2GiqclJ7zj4UroegyCqxm5xYhinB7bTByUxvmo/2Pih5NlmIp1thEM
	/aXv3fYyBMks0CX68unaGRa1y2CL6D5gHYLkT40IE2QZu9ewfzerqF6EB4ntSb3NTNWcsLFY9GtT5
	smAlVP4HrKqVr/uUzoMd2ijJxU5yoe4g0rp9vhu53uLc/eXMTa88/Me+czL9DtATR+bMx+tgVRGQr
	g0gJG06g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ThG-00000000i49-0ObV;
	Wed, 08 Oct 2025 12:55:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C0904300400; Wed, 08 Oct 2025 14:55:08 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:55:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251008125508.GJ3289052@noisy.programming.kicks-ass.net>
References: <20251008123014.GA20413@redhat.com>
 <20251008123045.GA20440@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008123045.GA20440@redhat.com>

On Wed, Oct 08, 2025 at 02:30:45PM +0200, Oleg Nesterov wrote:
> The read_seqbegin/need_seqretry/done_seqretry API is cumbersome and
> error prone. With the new helper the "typical" code like
> 
> 	int seq, nextseq;
> 	unsigned long flags;
> 
> 	nextseq = 0;
> 	do {
> 		seq = nextseq;
> 		flags = read_seqbegin_or_lock_irqsave(&seqlock, &seq);
> 
> 		// read-side critical section
> 
> 		nextseq = 1;
> 	} while (need_seqretry(&seqlock, seq));
> 	done_seqretry_irqrestore(&seqlock, seq, flags);
> 
> can be rewritten as
> 
> 	scoped_seqlock_read_irqsave (&seqlock) {
> 		// read-side critical section
> 	}
> 

Hmm, on first reading I was expecting that to be:

	do {
		seq = read_seqbegin(&seqlock);

		// read-side section

	} while (read_seqretry(&seqlock, seq));

for lack of that _or_lock() wording, but I suppose we can make that
something like:

 	scoped_seqbegin_read (&seqlock) {
		// read-side section
	}

which is distinctive enough.



