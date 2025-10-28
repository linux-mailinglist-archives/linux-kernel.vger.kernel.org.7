Return-Path: <linux-kernel+bounces-874537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8189C1688B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 840474E23AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A21319CD05;
	Tue, 28 Oct 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UU9S52JQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DA6158857
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677147; cv=none; b=qkuI7STwFTJ2eXIAwjd/dCObOsnKO/fPSnk0+2WLDsgXhW6A/IPdeU2Dyef+5mqDd1jLTmjkgBp2fjsTb6ZLUPnoPXtsAzhZzRRRti+6KF54Nf9TCbfZXnJjfGbNEbpvxa10fKx8mgMkzWCVN3W7yaE9QPCHgev2Y/fwXyxIdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677147; c=relaxed/simple;
	bh=V5IdyYHEMYO5vYmoiwuQmcfdLpxkatw8s9BHecfCtKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMfW+F/1eQxkel6kVufuaJdvSwsqA+rtJHZRhsIUCWLbfScZCdDI+pQ4o88ceSy8hieMtdIhyxzMZXj4dWvv2IvBuDZb6BHARiCTF4JIM+rO2hb85VyMlCTIJX0FwPKQ9XiJXzrSEhpubIbuAGgdH/pR2U8Myi6k7vsh8cFfezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UU9S52JQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V5IdyYHEMYO5vYmoiwuQmcfdLpxkatw8s9BHecfCtKw=; b=UU9S52JQpZGPFtdU/pV4uqsadE
	bK9ppixL/u3az7/tw0MlOpuNplrZ8jmquQuJv1+560dK1c5Z9OUB0z6kvsOLaca3skZJLY86zR7F/
	77J1bJTPa7aFuvwefDB3Tfmbjct7JxDVS2umuxHjoeLZLucGiqVFPAoo2aCwJ9NJqkTexp7f7i9ol
	5EGoUtpGICZhvdOnNS7Lapjcbxcu1P5EFVXNZl9uiDRhLeW2Zj/ZHPJFX98hgE+QGpsdleMW9k3rO
	pyhZz+dEVb3CILqRZ4t409hepo4B6rByxJhUoFXDwzurQfds0fT2dHFilcByIUhR3k5Vh3xoPQYet
	xJm3SYbw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDohN-00000004klX-3rNo;
	Tue, 28 Oct 2025 18:45:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 36E0030023C; Tue, 28 Oct 2025 19:45:37 +0100 (CET)
Date: Tue, 28 Oct 2025 19:45:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/2] Fix SCHED_WARN_ON()
Message-ID: <20251028184537.GC3419281@noisy.programming.kicks-ass.net>
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
> SCHED_WARN_ON() uses WARN_ONCE() and WARN_ONCE() uses printk(). Using
> printk() from certain code paths in the process scheduler is not allowed
> because printk() acquires the console_lock and this may cause printk()
> to sleep. Sleeping is not allowed from many paths in the process
> scheduler. Hence make sure that SCHED_WARN_ON() uses printk_deferred()
> instead of printk().

Yeah, so no. I hate that deferred thing with a passion. It means your
warning will never make it out if something fatal happens.

The printk() people have been working on fixing this for a long while
and I think they're close. All the crap consoles will get threaded
printing while the useful consoles (serial) will get atomic printing.

Also, you should never hit these WARNs to begin with, and if you do,
that lockdep splat is the least of your problems.

