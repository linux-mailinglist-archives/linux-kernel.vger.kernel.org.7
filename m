Return-Path: <linux-kernel+bounces-793125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AF9B3CEE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560D41B2216D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3572DC344;
	Sat, 30 Aug 2025 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aSSaVEyh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C45C2FB;
	Sat, 30 Aug 2025 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756580847; cv=none; b=Obx7QYgs51lzIF9ap6022bUivx6Y3ibPDq4xDAq72l76LsFR0HXKZ3Bl1AFIWKvaeTnM+KWKeJSrW04M3bekeM+yHSXFq/aNOPvKWnhsunofPCGsSNCepHthuBvSfXcaMYGfHmlvk70hjqxMyTUQ0ZOgCO6NL+bODFRXo7rBINw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756580847; c=relaxed/simple;
	bh=QYzueCTVYdbX1zon/h03kw3Kg4oJHnza55f2turo7rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igc7MZy/Calb0Z87b3RoahLs27tBjT754Ei3Zj1HtYY6s4OY89KSEmA9IJaA8kjHVhEeDfB7dyLl5Qvw2CERIJEXosgZiBLedwqk9AmWVaJOhX6pKWTTOJm0bA8M82QifMwfZi9m5UyL4UmBYvqzIbcL+L9Env3MZF1Qf7oCHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aSSaVEyh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8TFzyfVafwm7YUGOiNBnfwDYZHKGsNjEqahwV+6kUqM=; b=aSSaVEyh7oFxUSCCIohr5jjF6/
	ZQur9dJ5bm6zFxbgGcMH9iqEo8mjd9J16zYsgSHAkIshdND61u9Egh66DTulw/UAaOsqaKQgQLNn+
	sibeiQOVHEAYvSW5fWl97F2+azlKTM8rPzqkStxMSATp3Xjz7SeERa7GtWlz0cB8+joIlAjZ0qyD1
	jHdlmqagA4d8mmldU2TWyW34CWTgb+1Yyn51xFZVkWSJ2OgP5XYa9Kl03AcaDGZ0F+Lw8+a7vqqyn
	44ysYXqFYASt733WVK5YXgwxes2Sk2hpopL26NkPNULQ23IjlL3yBpSSdWwN2LydUr+Mir3nmYVAK
	pdkoSDNQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usQv0-0000000G8IQ-37i7;
	Sat, 30 Aug 2025 19:07:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 41E013002C5; Sat, 30 Aug 2025 21:07:18 +0200 (CEST)
Date: Sat, 30 Aug 2025 21:07:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrei Vagin <avagin@google.com>
Subject: Re: [PATCH v2] docs: scheduler: completion: Document
 complete_on_current_cpu()
Message-ID: <20250830190718.GS3289052@noisy.programming.kicks-ass.net>
References: <20250824-complete_on_current_cpu_doc-v2-1-fd13debcb020@gmail.com>
 <87a53h3fzn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a53h3fzn.fsf@trenco.lwn.net>

On Fri, Aug 29, 2025 at 04:44:28PM -0600, Jonathan Corbet wrote:
> Javier Carrasco <javier.carrasco.cruz@gmail.com> writes:
> 
> > Commit 6f63904c8f3e ("sched: add a few helpers to wake up tasks on the
> > current cpu") introduced this new function to the completion API that
> > has not been documented yet.
> 
> For a change like this, it is a really good idea to copy the author of
> the original patch and others who were involved in it; I have added them
> now.

This really is a rather specialized thing -- not sure it makes sense to
have in the document.

> > Document complete_on_current_cpu() explaining what it does and when its
> > usage is justified.
> >
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> >
> > ---
> > Changes in v2:
> > - Rebase onto v6.17-rc1
> > - Fix patch formatting (drop --- before the Signed-off-by tag).
> > - Link to v1: https://lore.kernel.org/r/20250703-complete_on_current_cpu_doc-v1-1-262dc859b38a@gmail.com
> > ---
> >  Documentation/scheduler/completion.rst | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/scheduler/completion.rst b/Documentation/scheduler/completion.rst
> > index adf0c0a56d02..db9c131f0b62 100644
> > --- a/Documentation/scheduler/completion.rst
> > +++ b/Documentation/scheduler/completion.rst
> > @@ -272,6 +272,10 @@ Signaling completion from IRQ context is fine as it will appropriately
> >  lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never
> >  sleep.
> >  
> > +Use complete_on_current_cpu() to wake up the task on the current CPU.
> > +It makes use of the WF_CURRENT_CPU flag to move the task to be woken up
> > +to the current CPU, achieving faster context switches. To use this variant,
> > +the context switch speed must be relevant and the optimization justified.
> >  
> >  try_wait_for_completion()/completion_done():
> >  --------------------------------------------
> >
> > ---
> > base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> > change-id: 20250702-complete_on_current_cpu_doc-94dfc72a39f8
> >
> > Best regards,
> > --  
> > Javier Carrasco <javier.carrasco.cruz@gmail.com>

