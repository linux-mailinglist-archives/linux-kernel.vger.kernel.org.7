Return-Path: <linux-kernel+bounces-858576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF3BEB2FE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0C7435E6DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6261D5CE0;
	Fri, 17 Oct 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DXnsiiY2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B88D2FFFA0
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725160; cv=none; b=B7Tp83+DgNUaeIVTt0FHIum60m1VsEgDXUbZSEqMwq5IwxHucZBCR3WD4Lti/P7Raf1GrGs3t2xLLpEOHIeXIFz4/5ToEH4sakEE9A3vkaZR0wDSOq3opjXgeeP2VVTfHYImO6axw7naLigwcWOKA6kFAmajDyCJhyq0+pSZ+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725160; c=relaxed/simple;
	bh=0VUJLZ3I4mtjqRs+CwUQzNRrK66FrFJHQjRJGkP6kq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S94/7UHGUVGp0PK5SnJMluKbeaXAg4TxM+PwtCyQ7MU7hItIqiMb3ZodiXmhqim+uIrXvR347LL7QJH5vjGQBmqoX3pGRppaYSq3m+bd0TJG8ZfhSUeFcPH1o4d3HSIl8nm3oX3u476vCJm4LykCSTEuubu32utMdKW1srUjs8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DXnsiiY2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7uUhkATpARUrToc6ttPKITddJF3W/eoSEDtVOLu74zE=; b=DXnsiiY2ZqZt4F3aTCVS3uJdAS
	dHTDPx8PsNw7c5FK++GnJhoa5mbvnQWBGdot8AGXd+nRGIxJDcy5UjcB0w6BDgux2GLQh8vFIf6Lh
	uKkw74+adnmzNsIiEIHCZxEDPGlk3xUNoQRiA8uHArZ9W+zeU7BiQcDuQoX4dQgPlxEsAv0aYNBkF
	4eShhz9Cgv592tvkcWvXpgzYjJLlOHp3NYCRsgCssoddZBAMwhC2lpNdXTCaEN+Ooh6U2qxAHDI7U
	8hp4fo7wDJDbFp5stTYbJxC3EONQCAM7c3HRSuM0zoDpY7NsGr/aDE9/GE39Shh9UIRkEPtWX8YQL
	1YYzocCw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9p2k-0000000H8MZ-1531;
	Fri, 17 Oct 2025 18:19:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F86230023C; Fri, 17 Oct 2025 20:19:11 +0200 (CEST)
Date: Fri, 17 Oct 2025 20:19:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Jeanson <mjeanson@efficios.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Florian Weimer <fweimer@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	TCMalloc Team <tcmalloc-eng@google.com>
Subject: Re: [patch 06/19] sched/mmcid: Prevent pointless work in
 mm_update_cpus_allowed()
Message-ID: <20251017181911.GR1386988@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.694547089@linutronix.de>
 <20251017111223.GD4067720@noisy.programming.kicks-ass.net>
 <87y0p9zo9y.ffs@tglx>
 <20251017175853.GH3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017175853.GH3419281@noisy.programming.kicks-ass.net>

On Fri, Oct 17, 2025 at 07:58:53PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 17, 2025 at 02:49:29PM +0200, Thomas Gleixner wrote:
> > On Fri, Oct 17 2025 at 13:12, Peter Zijlstra wrote:
> > > On Wed, Oct 15, 2025 at 07:29:34PM +0200, Thomas Gleixner wrote:
> > >
> > >> +	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids)
> > >>  		return;
> > >
> > > FWIW this doesn't work on architectures that change their
> > > cpu_possible_mask around (eg. Power).
> > 
> > No. Power does not change it after boot either. Half of the kernel would
> > explode if that'd be the case.
> 
> Power very much does changes cpu_possible_mask; it doesn't change
> nr_cpu_ids. Anyway, the point is that a full mask won't be nr_cpu_ids.

Gah, bad memories, it is cpu_present_mask they change.

> Same is true when you offline a CPU come to think of it.
> 
> Same is true if the cpumask is sparse.
> 
> Anyway, just saying, checking against nr_cpu_ids might not be the best
> shortcut here.

Put another way, nr_cpus_allowed == nr_cpu_ids only work when none of
the masks involved have holes. The moment anything {possible, present,
online} has holes in, it goes sideways.

