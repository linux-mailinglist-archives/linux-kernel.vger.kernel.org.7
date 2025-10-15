Return-Path: <linux-kernel+bounces-854699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82AEBDF264
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBD73C3AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA32283C89;
	Wed, 15 Oct 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S7BRx3ra"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C035146593
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539616; cv=none; b=PtZ8U0ygnoYG6as0tYYrscT4t2RBIpE4mYx+tNjgY0QSQNcNsj0/mZgl4rrLCcZz2e4gmE5ZatFyINU83UVdlB0dHXZs6cyrAMLIPG4AlVzC1P9G8iWkJctMUilGB6C9Dd+3TKSNusOeSiu4oqMoyBjpmVdYhb4/YGQ9zJv7yRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539616; c=relaxed/simple;
	bh=CUcy4yb6zqJ6yQqle5sWCAFN9kGa1AzWStgJgCWPSJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ5m89QxgFG4kZRVPNN2j7C+kWOLUcZuxbQd4i8YrOhSGZSLuLSlRpTRHgf8dI1cw2Qc9jS7Cxs31Qk1safJR71Zlb+MfSASMHhhiE5tyUdPtFblnhKsIcc5U/VQU+0/RbRheHx9OZvsNxwVJ6LpG5RwExeB6Qi8f/g61C3ZOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S7BRx3ra; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D/hhU33FsHS7lrWWEjiPF3sa5mLSTsjRKHC8iMsRWx8=; b=S7BRx3raDJkFzPOKjqjo9ZKOu2
	jBtZE3iqTcNsSB73eeZhth7KMmOXUKggfNy5IbSUkomQnbgGVLYIFtjdBE2yDDNvAW6ig2dfmtnak
	ifM4llYkW0oHlxciQTSt3h35QxSzYR+SuIDS8SZMSnLlhlSND8WDcK8H/0H5D4+8lHzSXKNYaVMX1
	U0290eSG5zN3iOwPzfH2CCQJc5F62zH5A1Vy4Rkyljrli+jClAYBMItgbNOFD2ynVTKebbaaeFDcd
	YjiIGxjwKRsURo4Hm2+kkBVFPI32/q3RxEE36gSbdM6NfHN3jfOZR5+u3Y9o9hlLkl+ppACqxa0jj
	Ec0ac9Pg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v92m1-00000000DKB-0z5b;
	Wed, 15 Oct 2025 14:46:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3D0A430023C; Wed, 15 Oct 2025 16:46:41 +0200 (CEST)
Date: Wed, 15 Oct 2025 16:46:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peng Wang <peng_wang@linux.alibaba.com>, mingo@redhat.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, vdavydov.dev@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Clear ->h_load_next after hierarchical load
Message-ID: <20251015144641.GA3168635@noisy.programming.kicks-ass.net>
References: <bc08fcd528bad11311cd25de37962eb1ce0e7879.1760530739.git.peng_wang@linux.alibaba.com>
 <20251015124422.GD3419281@noisy.programming.kicks-ass.net>
 <CAKfTPtD-RJoMEHSQToF_578KZ=WszR+xStxNghiWpv4asnHBoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD-RJoMEHSQToF_578KZ=WszR+xStxNghiWpv4asnHBoA@mail.gmail.com>

On Wed, Oct 15, 2025 at 03:14:37PM +0200, Vincent Guittot wrote:
> On Wed, 15 Oct 2025 at 14:44, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 15, 2025 at 08:19:50PM +0800, Peng Wang wrote:
> >
> > > We found that the task_group corresponding to the problematic se
> > > is not in the parent task_group???s children list, indicating that
> > > h_load_next points to an invalid address. Consider the following
> > > cgroup and task hierarchy:
> > >
> > >          A
> > >         / \
> > >        /   \
> > >       B     E
> > >      / \    |
> > >     /   \   t2
> > >    C     D
> > >    |     |
> > >    t0    t1
> > >
> > > Here follows a timing sequence that may be responsible for triggering
> > > the problem:
> > >
> > > CPU X                   CPU Y                   CPU Z
> > > wakeup t0
> > > set list A->B->C
> > > traverse A->B->C
> > > t0 exits
> > > destroy C
> > >                         wakeup t2
> > >                         set list A->E           wakeup t1
> > >                                                 set list A->B->D
> > >                         traverse A->B->C
> > >                         panic
> > >
> > > CPU Z sets ->h_load_next list to A->B->D, but due to arm64 weaker memory
> > > ordering, Y may observe A->B before it sees B->D, then in this time window,
> > > it can traverse A->B->C and reach an invalid se.
> >
> > Hmm, I rather think we should ensure update_cfs_rq_h_load() is
> > serialized against unregister_fair_sched_group().
> 
> The bug has been reported for v5.10 which probably don't have fixed
> done "recently"
> commit b027789e5e50 ("sched/fair: Prevent dead task groups from
> regaining cfs_rq's")

Yeah, but nobody is going to develop against that ancient thing. So the
above is just one more patch the would need to get backported.



