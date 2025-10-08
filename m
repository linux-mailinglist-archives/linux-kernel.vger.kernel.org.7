Return-Path: <linux-kernel+bounces-845543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6374BBC5532
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55793A956B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EC728850F;
	Wed,  8 Oct 2025 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GKcw8mZc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C099287275
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931734; cv=none; b=YGgoRlj5WFMMOuwgWSj5dBgu/rZk0JMX8MhxV/yOLYb6wnLLgaQhqEgPLbJPkDL/c2fguuRXydy9jXbghtBb1A5kJ4xWcM7IduIzDkd6McaUpudURVh1qI2EgMUWLuA6hX2Ki/j91Y1/z6djdcgINuctmmLbLLpJ9RamsLxvVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931734; c=relaxed/simple;
	bh=lrip0KgLMKK3pNHH0Ud6S9tMoD3t1XAVllMaHY2p2r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HihBXOINhG/f/ZtONjTIgIBESmB12sSN+QUrCGwkg5uOUx5GFn2T85r/Nt+L/3y1Wxc+Y6Z66cJhGKA2WrksA4zgMPyJhP5zjZsuBmo06p/VN36io6ycUgvM+ydG6gGGWcd3iiN/m25s5fexZYrg3kkNLjR6zxGodEV49rghQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GKcw8mZc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ffOeVfrTZdWJgp8aiXi94R7mRe5ESJ09yRXisMDKLT8=; b=GKcw8mZciyRacegqXCkcGuQ2Ik
	qDZw3jy90+7keIjSu0INRpQakutbcJm20fsUwG0wuNZdfI58+K7AADwU9gAST5e+eyhfvsb39kjmX
	lUfGe3NlGZjNaXX/gBe9AjqzrIR90N6UWOc+s/2XBeXMgc3X+hkAzY6DZPFfaRIXBaVMw7MiQ+sti
	khmxn3S0F6WbZYeY//Zuff6kXzlK6SCcMWX+FVUzrmNAY3CXiwgYjyNX2Mm5JJQCg1n7Dr+bQYLfs
	ZZSzIUG8blXiSJJ81VG4lcMM2+7MRDLUTCTxg2K0GxeaYAzfSLvTXIxHyD5/nrLrdY5YUTBUwu9qG
	q7pp/TqA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Udb-00000000jii-0W8a;
	Wed, 08 Oct 2025 13:55:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 98313300400; Wed, 08 Oct 2025 15:55:26 +0200 (CEST)
Date: Wed, 8 Oct 2025 15:55:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251008135526.GV4067720@noisy.programming.kicks-ass.net>
References: <20251008123014.GA20413@redhat.com>
 <20251008125639.GK3289052@noisy.programming.kicks-ass.net>
 <aOZjXq8u8fV_kABe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOZjXq8u8fV_kABe@redhat.com>

On Wed, Oct 08, 2025 at 03:13:02PM +0200, Oleg Nesterov wrote:
> On 10/08, Peter Zijlstra wrote:
> >
> > On Wed, Oct 08, 2025 at 02:30:14PM +0200, Oleg Nesterov wrote:
> > > Only 1/4 was changed according to comments from Linus and Waiman,
> > > but let me resend 2-4 as well.
> >
> > Shall I put this in tip/locking/core once -rc1 happens or so?
> 
> Would be great ;) If nobody objects.
> 
> Can you also take the trivial
> 
> 	[PATCH 1/1] documentation: seqlock: fix the wrong documentation of read_seqbegin_or_lock/need_seqretry
> 	https://lore.kernel.org/all/20250928162029.GA3121@redhat.com/
> 
> ?

I've picked that up too and stuck it in front.

> OTOH, if this series is merged, this doc fix should be updated to
> mention scoped_seqlock_read()...

I see a patch [5/4] in your future ;-)

