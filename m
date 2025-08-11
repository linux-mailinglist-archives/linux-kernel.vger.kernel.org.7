Return-Path: <linux-kernel+bounces-762933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F2FB20C80
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194823B654F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F392DEA96;
	Mon, 11 Aug 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xn+t3I5C"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72C2DCF7C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923255; cv=none; b=tdJY4zUIqhIdggF5R8VBSxMia1Aq8+oT55rd/Gxgam/H5F0nBULzztBFaCtjg8/amvyWV2H2kN8P55MK0J4KoFRJ1DsMW/W7lN7gpLXf3dPUNHUFiXaTYdict5/zG0aawE+UvufbXiRoCJmkQwU/I8ANb4Vmfe66/y5hae+Dp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923255; c=relaxed/simple;
	bh=CiYdPb3CphugUI2pUUw9uiBPRzqErXbI0qY3SC4e3Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpXLETlnMbdyBp0KLqfTtRk2N4bw9Ajap48i/qccPisOS2wie+ugGWW6T5zplQlwqHtHZWU1lqVGXf7QSmeuwwfWfH4sGSaVRJWdFS/4sR2Qw16I6TPxkeq+EjtNj096XJoep2NyungZTqpb5Vx32tPs6xZDKm6UQcaSQpBupgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xn+t3I5C; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zQCFIUmkRpQb+xwoOkifhrGoou5UFm1gv2WNuwn/9+s=; b=Xn+t3I5ChddUd73OttqY6pKGmA
	zxR/Dzm09wBPTIL02hV/KB5r76/7V7E6II6ommjMxLfOV9++gIJVoglzNH5rifpD++D/b/W7e2ggu
	UAv1XnpluJiPU/dgmEhZIrO3NcbW2aVP57xdhAHqhO/0UtACmxpfIMAOVy1L1ZX2VHNhf+1TfjzuS
	OdW9bzbxupyiZsWV/cQIcUNCtzEJ6Ork6cagCFrCAhGZ3RP8RSPDeH9CfTrdwCxTuv1biEU8RZO/Z
	2XW31q7TTYU+uHoeEj17IHAGKqnNGxPk2ZET4YHoU9H5I0kiM5ulYMmzh2qt2uiHeV/UwYkaDVfaR
	Ya3QR2TA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulThh-0000000FQUD-10oH;
	Mon, 11 Aug 2025 14:40:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E4C8300310; Mon, 11 Aug 2025 16:40:48 +0200 (CEST)
Date: Mon, 11 Aug 2025 16:40:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [patch V2 m@/6] perf/core: Split out mlock limit handling
Message-ID: <20250811144047.GA4067720@noisy.programming.kicks-ass.net>
References: <20250811065859.660930338@linutronix.de>
 <20250811070620.463634790@linutronix.de>
 <20250811104940.GF1613200@noisy.programming.kicks-ass.net>
 <87o6sm81wt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6sm81wt.ffs@tglx>

On Mon, Aug 11, 2025 at 02:42:58PM +0200, Thomas Gleixner wrote:

> > Does this not also need this? I found this stray user_extra when I
> > eventually removed the local user_extra variable.
> >
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6997,8 +6997,6 @@ static int perf_mmap(struct file *file,
> >  	if (vma_size != PAGE_SIZE * nr_pages)
> >  		return -EINVAL;
> >  
> > -	user_extra = nr_pages;
> > -
> >  	mutex_lock(&event->mmap_mutex);
> >  	ret = -EINVAL;
> >  
> 
> No. That's how user_extra is initialized in the first place.
> 
> To remove that nr_pages must become an argument to that function.

Ah, I see. Let me go fix that.

