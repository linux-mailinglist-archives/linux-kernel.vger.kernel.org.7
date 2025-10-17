Return-Path: <linux-kernel+bounces-858555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD4FBEB224
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6373C4E869F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7154332C93A;
	Fri, 17 Oct 2025 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bjuEygcY"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B602773E4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723944; cv=none; b=iArNCzJFEPt6lNqmHaxnX8+MMZkfyvhnRa/Oecr0zLnTmpqKLv4SNZdSTDfoDYd1IRHxObVwWW3AN86Oqm8itbudA7LA6AOF+iNkPk5aC/yN3DtWbeZk/Zh1r18+oq1Pa8Q5ohA7dgPt2nAq2JCSYz1RDd4oeIGa5o21rQeksIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723944; c=relaxed/simple;
	bh=7Mb46ltmdC325CD+SULIZc0XpYLMVjzjkuj4Rwf3jAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNnXn+FbvdwUR1lfCJNYzDIf8LEWGeJ74bWsXGIRwId2B4+LwtS/vGiTH3YAUnZb/ONBC2tZyi1IKDqKmKR4EKjg2YYdAQ8kDh2Jg8nKEWOKmAae8S5Wy4qjE1g2hrsBF8pLbWth6dw+9iVaZzc7ef1MRJ4tJTzagTCAw4TOxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bjuEygcY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=srd5DvNuasQwWmaDjCZCqIGNlq6KrnNYPcRI4rxaOZY=; b=bjuEygcYeynfrlmlS2G5BVVJsG
	SYaBq3th8gDA2/zbvcJ0vQuG+W+ortI+iUNMOCm1oArRAPVrhJ0XivRsFzlOuq/mLpIreJe2GP+PY
	6cGwF7c/iFBvKGsqi9kOx2eCwFTV+SrKqBZeuoMOttT232FB84J7jB8dDBnZgkJdUPKoMsYBsE7wx
	x8Encb8HzBW2OB63VofTti7YMBC8tW/i/fmw563r4X4hSiehERokPFiuu7tk9N8rVL91p+lPz02kb
	IBgrt/P+FQIKyLYLTmlIFeVDiCYuP2Aq93OuPvQP+KsqFiHoHpG0n5/d5Wn2ydVLhCWSIgc1fTQgY
	1evI73Ew==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9oj7-0000000GnvB-00yz;
	Fri, 17 Oct 2025 17:58:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3A02530023C; Fri, 17 Oct 2025 19:58:53 +0200 (CEST)
Date: Fri, 17 Oct 2025 19:58:53 +0200
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
Message-ID: <20251017175853.GH3419281@noisy.programming.kicks-ass.net>
References: <20251015164952.694882104@linutronix.de>
 <20251015172834.694547089@linutronix.de>
 <20251017111223.GD4067720@noisy.programming.kicks-ass.net>
 <87y0p9zo9y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0p9zo9y.ffs@tglx>

On Fri, Oct 17, 2025 at 02:49:29PM +0200, Thomas Gleixner wrote:
> On Fri, Oct 17 2025 at 13:12, Peter Zijlstra wrote:
> > On Wed, Oct 15, 2025 at 07:29:34PM +0200, Thomas Gleixner wrote:
> >
> >> +	if (!mm || READ_ONCE(mm->mm_cid.nr_cpus_allowed) == nr_cpu_ids)
> >>  		return;
> >
> > FWIW this doesn't work on architectures that change their
> > cpu_possible_mask around (eg. Power).
> 
> No. Power does not change it after boot either. Half of the kernel would
> explode if that'd be the case.

Power very much does changes cpu_possible_mask; it doesn't change
nr_cpu_ids. Anyway, the point is that a full mask won't be nr_cpu_ids.

Same is true when you offline a CPU come to think of it.

Same is true if the cpumask is sparse.

Anyway, just saying, checking against nr_cpu_ids might not be the best
shortcut here.

