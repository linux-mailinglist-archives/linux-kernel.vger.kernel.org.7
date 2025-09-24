Return-Path: <linux-kernel+bounces-830012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8904AB98731
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFFF219C35CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C3F2580F2;
	Wed, 24 Sep 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ne3Yo2xA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85354C98
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697109; cv=none; b=Fprc4DMfGu16YmLP/tb1Tosfx6K+hDWaUnk8N3OY7vaEBtYgrfPQLGFhJrjhkOM8lsefbocUY4Ic4FF2m4Y5XzcePqGuofHBLK1rF6rsAZauOIQVDbdlmicfusC+boe6hTG9oDzlw5Bzfa7Mu6mD9sJJ3RDJqFLXbfUzMn4RKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697109; c=relaxed/simple;
	bh=ugRI7ftty2KTuDsTmI8mgRbe8gTdkHKbCK8UKqwViwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7ZXZ2tLwAuk1gDNOV0FNZMLQbb56hNCCsDqNlmYQPqnCKg/ioOGRub6u6wrupgMslxERsFkYIQXQiKFJCK66262KcioGN2wpAN+2UMGbwPdBlYcYQw9avNiKVHeD7ZexSY8pkVNog6iEixB2Hg81mj7cvivI/DmkWQOc2dsGww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ne3Yo2xA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zyvqlxRPkGoEM8uPMuGmFis26pZ67ZErJB/icj1Kh60=; b=Ne3Yo2xAaVJPaC9UlZNr9zEHcy
	MuRDQ8eBWuB3RCCN2SjVHmhqRROFr+MmK843IhDjQlacAA1rXHCeQifoXsqUUrV9dUPNI1XsH5hK5
	E6mpup6N7W5iFwJxNUVWwKnE9QDeS1by+/rcPzpMBfwI4aRrCdvdzuZOQBb8jUF3lxmtzZgfN1NDG
	dMF+KReV/nXAhIoJIgORoyNqPaz5xuKHSODvtbHfLEMJidQsfO81E6K34XX4nk22yikqPSK8lAOsz
	ZprHNrX4fkA6HK9tpPL7Spl79hRPwqSNTL5QoMDX5zVVIJmksFWRQC/AY2UkxPW6FbPk+QgtCNgW7
	TYbHEsyQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1JSJ-0000000AdTX-2qnv;
	Wed, 24 Sep 2025 06:58:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3EE0830033D; Wed, 24 Sep 2025 08:58:23 +0200 (CEST)
Date: Wed, 24 Sep 2025 08:58:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: buckzhang1212@yeah.net, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/mutex:add MUTEX_CHCEK_INIT to detect
 uninitialized mutex lock
Message-ID: <20250924065823.GS4067720@noisy.programming.kicks-ass.net>
References: <20250924022500.2577-1-buckzhang1212@yeah.net>
 <dbba6b72-d270-4b7e-bb21-39ac8a46864a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbba6b72-d270-4b7e-bb21-39ac8a46864a@redhat.com>

On Tue, Sep 23, 2025 at 11:10:22PM -0400, Waiman Long wrote:
> On 9/23/25 10:25 PM, buckzhang1212@yeah.net wrote:

> A mutex must be properly initialized before it can be used. The kernel panic
> you listed above is expected and the panic itself indicates that the code is
> wrong.

> > @@ -269,6 +279,7 @@ static void __sched __mutex_lock_slowpath(struct mutex *lock);
> >   void __sched mutex_lock(struct mutex *lock)
> >   {
> >   	might_sleep();
> > +	MUTEX_CHCEK_INIT(lock);
> >   	if (!__mutex_trylock_fast(lock))
> >   		__mutex_lock_slowpath(lock);
> 
> This check has provided no additional value and it slows down the locking
> fast path.
> 
> NACK

Agreed. Additionally we have CONFIG_DEBUG_MUTEXES. If you feel there is
a check missing there -- you could argue that debug_mutex_lock_common()
should have something like:

  DEBUG_LOCK_WARN_ON(lock->magic != lock);

feel free to send a patch for that.

But don't go sprinkle debug code in !debug builds.

