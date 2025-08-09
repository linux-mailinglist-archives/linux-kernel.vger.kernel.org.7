Return-Path: <linux-kernel+bounces-761202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B152EB1F5BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ABA189DECE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8B279795;
	Sat,  9 Aug 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpqsAxnB"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881331F237A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754762025; cv=none; b=rrxqR6TowEyjjSMgjViepmQaZodBAldMgHRNjRl972DFIX1DQgKfrTiXtlvkD5UNDDKpfyixXdcOm+HqXiAeI/WcDuI2bPJBalzaIrQOQSoCnPQk7S+cgEgGwyKSQi9TRK2Q8nj/cR+ARzsEh+VEtMit/PtpYa8NzR+YeAq0jpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754762025; c=relaxed/simple;
	bh=tvrhy18IxwJ9b5tb/00QjHxRbjPJe0wD1R3zvUvvR/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw29SaP/SGbDUbtP3+Tt2+hBv+hSI9cyPWazTvk+BKPBpi2MYHw/a4cf0WTmj4dqWIdNo3+KdbotJw7eatgR7J0evkYfeokckk2j2sFl4Yn2u0W/dIUoobsbDXI0XqQqi5kTd6X9NjxpWjVrqx9zk0tgfnPJGVeNC0VtXhKilrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gpqsAxnB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P8Q6okkklAaY14XcctlL0AEEZpbd7u+rIv8Yr4uepEE=; b=gpqsAxnB8xdyNstaJEtm7JRXF3
	MVIX8LYpSosquRzL5y0WFAFNME3fv13XtgyzvjTYLfL3hUZq1qjYmIYYIUrYZshM1Nwr5GT3rekSH
	Afl8GCBA2t9PM2wnsUYR+mccdufSJn+8gCV3voifSOwwDa1tvROI9dzzTViTL5sdapHm27eNnjk+1
	4D5zdCSJLIUPZ/lJZOjGhQ/nviVpVmsWZXz502S54oPhJhtJKSgahZ7stHuvCV1PkJyqPzpI7nogH
	QFs26P9Bp5lQedCrOVrxBGY3qlrp39PXJ5yCI4TpIj3k13YoYiyzVPbBqgto+Fcy6rAGttKLetF/s
	2ApzsyYg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uknl4-00000002Qkb-400y;
	Sat, 09 Aug 2025 17:53:30 +0000
Date: Sat, 9 Aug 2025 18:53:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Subrata Nath (Nokia)" <subrata.nath@nokia.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: prevent RCU stalls in kswapd by adding cond_resched()
Message-ID: <aJeLGpT9vp7g0lj4@casper.infradead.org>
References: <AM9PR07MB78119166E41E86BE5E7DDCC0882EA@AM9PR07MB7811.eurprd07.prod.outlook.com>
 <aJdkmCP41RhNC9FH@casper.infradead.org>
 <20250809103845.21ca58f0a97c0c1f61c0879c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809103845.21ca58f0a97c0c1f61c0879c@linux-foundation.org>

On Sat, Aug 09, 2025 at 10:38:45AM -0700, Andrew Morton wrote:
> On Sat, 9 Aug 2025 16:09:12 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Sat, Aug 09, 2025 at 11:59:16AM +0000, Subrata Nath (Nokia) wrote:
> > > Fix this by adding cond_resched() after all spinlock release points
> > > in page_vma_mapped_walk() and in the main loop of shrink_zones().
> > > These calls, placed outside spinlock-held sections, allow voluntary
> > > scheduling and ensure timely quiescent state reporting, avoiding
> > > prolonged RCU stalls.
> > 
> > No.  We're removing cond_resched().  See
> > https://lore.kernel.org/linux-mm/87cyyfxd4k.ffs@tglx/
> > and many many other emails over the past few years.
> 
> tglx's email was sent two years ago.

... and there has been much progress since then.  Most recently,
https://lore.kernel.org/all/20250225035516.26443-1-boqun.feng@gmail.com/

This report is not from a recent kernel.  Subrata was good enough to
include:

Based on: v6.1.128

and I think it is very much on them to prove that this is still a
problem in 2025.


