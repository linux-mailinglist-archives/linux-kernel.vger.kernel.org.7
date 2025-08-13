Return-Path: <linux-kernel+bounces-766256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8BB2445B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970431887376
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1FA2ED84A;
	Wed, 13 Aug 2025 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aNKCOXLt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CAA23D7D3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755073969; cv=none; b=pQdNg6mKotlK74PgG/5nuRyUICBGyc2Mf3Hq1lm2fmzM1Y0GOxeZLRCbfNPDrcfU8hDqgqe0sLDCzB/fM5Yb0QJDIBg5jPv7d775IQO4+ppmhFV/za/VK5rY3m6ToY1NXpupa79zL0Ygf76tTutAcfqGrsHm0DEHE3/hfSt0wRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755073969; c=relaxed/simple;
	bh=oIHlQtMEse0z/tSnN/lQgCN+GpYJuzYQrEo9ZdLRnls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn3KS9V9bkQWNE7aosAoCuvk5vbMBvEkDPQpS+3Knp9yjpIORjk/6+mUnpBRHLov2swyTzTvy8uqJ63D6L2of9ix+zKHyhEulwk5lVWxx1M660XOVSPmPejqS6ARSsQh50op10W6nHOingfZ0Gd1/LasFRJgDKDL1O6oIisy034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aNKCOXLt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LplG7SvEZQzg+ZHRq3ljAd96FVRD8uwu9tVOJ0ixzVA=; b=aNKCOXLtqP53UVFcha+4EHplR5
	A0OiCPfr75yf0YN+U2CVMB6lnDrAVD5Fo2FM8jHQ4XH4Y8jrUS56zMMZSjG7NzSDUJfjuQj8yxM69
	/aPDKKotMwovJfVSGjVfo6Qh5CDAXXGTH9Uq8fVOQ9moQh2Aq6epFj1+3jjd4lOE4GkY41CcCo2QR
	hwcE7rfs7akVV7IW+IKkpsxLNyQXgLVhwsZWMR5Xj0ay7Ef8+2pVZR+k2MIgQ1Fl9k2lgfq//uOrK
	HnOXSuA1EphxVMTXmEWUFLGROFjOP/6Mwjnx/xSQ3Phi8WFugefy5UV7bGuz6OWWa8fVVa4g+DFMC
	QzSoolRQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um6ua-000000072eZ-0oJo;
	Wed, 13 Aug 2025 08:32:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6A43F3002C5; Wed, 13 Aug 2025 10:32:44 +0200 (CEST)
Date: Wed, 13 Aug 2025 10:32:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
	torvalds@linuxfoundation.org, mingo@kernel.org, namhyung@kernel.org,
	acme@redhat.com, kees@kernel.org
Subject: Re: [PATCH v3 13/15] perf: Use scoped_guard() for mmap_mutex in
 perf_mmap()
Message-ID: <20250813083244.GL4067720@noisy.programming.kicks-ass.net>
References: <20250812103858.234850285@infradead.org>
 <20250812104019.838047976@infradead.org>
 <a9085638-b560-43a6-861e-74e52b431783@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9085638-b560-43a6-861e-74e52b431783@lucifer.local>

On Wed, Aug 13, 2025 at 07:42:41AM +0100, Lorenzo Stoakes wrote:

> > +	scoped_guard (mutex, &event->mmap_mutex) {
> > +		/*
> > +		 * This relies on __pmu_detach_event() taking mmap_mutex after marking
> > +		 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
> > +		 * will detach the rb created here.
> > +		 */
> > +		if (event->state <= PERF_EVENT_STATE_REVOKED) {
> > +			ret = -ENODEV;
> > +			break;
> 
> I don't absolutely love this break-for-what-is-not-obviously-a-for-loop
> formulation (I know scoped_guard in practice _is_ a for loop, but obviously
> that's hidden by macro), but I guess hey it's C, and we have to do what we
> have to do :)

Right, don't love it either, but the alternative was a goto and that's
arguably worse, so meh.

> > +		}
> >
> > +		if (vma->vm_pgoff == 0)
> > +			ret = perf_mmap_rb(vma, event, nr_pages);
> > +		else
> > +			ret = perf_mmap_aux(vma, event, nr_pages);
> >  	}
> >
> >  	if (ret)
> >  		return ret;
> >
> >
> >

