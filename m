Return-Path: <linux-kernel+bounces-874540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47578C168A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEB61B280E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3134DB67;
	Tue, 28 Oct 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gR3WJ1cD"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF08346A0A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677462; cv=none; b=QsImeqrUk4GP5tIgl+KEzA1mEqZND3pRMsYNLozUtrZnwhrFEAlqgXyh0DogOMURUqDpZhtC1TAaK82H24FXeG4UqqrJ9BkdYhZaS8DfWCsXZUcGTKpMhzYnD0SFo5th5eOpHpGxFqoo1Z53mp4q6rBb2VL9iEX8jj4jQvvfywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677462; c=relaxed/simple;
	bh=ld5tCq1+z720UMmJlaqQoFmNDMyCpg4lqpAg7vwEIhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St2X+OmjuaAziynY7AsYEv1tnYpFRn8dvCKo/czINkxwfUokpoPzYMM7qPL1uuT0ZYIjYwuyzVfcqwobigFrwk5AQv7HdBQ6r102ZzAiPg6YNUOjDKRy3ejgbBXL1YduD3TUn9rnGCcCbEMO/IhBYPR3NJy3uEFF9ES9DYwDT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gR3WJ1cD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i6yI/BPE3RzGzzA16f/8ZqPs7xtDmmVIO8Q5cNQ9aGs=; b=gR3WJ1cDpaaSGTRmSAVX32GJ7P
	Ywtbwm+xqK4v8mObj+Lkz1zjeX5pXMqumpix3ESeKDLb8/8qg/HOXYeOv5nz7rZEqA14EHGht1KbW
	8uh/DNQgqH7vhZvGq/pU+7nBWii08v42bkevqlvlURV7QxODuQyXN6bETg74NLDJIXHwf60UfEITV
	UMFe8Dss+YDX+bDpsaXKyyCZKrlrR+OAwftcQwO3jWykgv8gyKKDlt/G5a29GH1eo46SqRfyBgRjD
	J28DWgJ8YbjElVFPLZ8GhsLNgyQ6UvP5FFbTfO0eaMC4KprytlPB/s+MHx6youl6Y9SWhS9pxNkUU
	7PX3lDfg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDomU-00000004pYK-3liT;
	Tue, 28 Oct 2025 18:50:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E4D13001D4; Tue, 28 Oct 2025 19:50:55 +0100 (CET)
Date: Tue, 28 Oct 2025 19:50:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/2] Fix SCHED_WARN_ON()
Message-ID: <20251028185055.GD3419281@noisy.programming.kicks-ass.net>
References: <20251028165059.682306-1-bvanassche@acm.org>
 <20251028165059.682306-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028165059.682306-3-bvanassche@acm.org>

On Tue, Oct 28, 2025 at 09:50:58AM -0700, Bart Van Assche wrote:


> +#define SCHED_WARN_ON(x)				\
> +	({						\
> +		bool __ret = (x);			\
> +							\
> +		if (unlikely(__ret)) {			\
> +			unsigned long __flags;		\
> +							\
> +			local_irq_save(__flags);	\
> +			printk_deferred_enter();	\
> +			WARN_ONCE(__ret, #x);		\
> +			printk_deferred_exit();		\
> +			local_irq_restore(__flags);	\
> +		}					\
> +		unlikely(__ret);			\
> +	})

Also, this will generate absolutely atrocious code.

