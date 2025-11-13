Return-Path: <linux-kernel+bounces-899532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BCEC5809F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3803E3590FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395532820A9;
	Thu, 13 Nov 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+5URevD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976BF201033
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045379; cv=none; b=g7KuuQ4XvZuRegNNnZzegsaQ94TuNSzM60RGslgEiHNKTRStQPbeSHrHGic+s1inBFmkHCxkIz+b9sp+xZHH1r+HxaOUcIPQvz8EBM5V5l6l2YxI9Q/vF+IVE6PEBBHunWL/tajKAMdc3kAnwNAYisBuz/LF/XuPDcvh0OLcvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045379; c=relaxed/simple;
	bh=nKs52qLHIqK7qd0jS88AVYdqV64a1C2FUSD1K+jjxoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsiqOM9WXvfsapjuoQQRiG/RiFUtTi3gpuDUZAIyGp8/+K6gV+GdkfZq9QPH2LxzjXVsFnx9NZBtcF1qTEKSmv3JllPR3R4vlp21TfRQmzdlbYRdt5e+kMMmRpmS/nWh6hKIgFUNV+uRAwDP/Io83JGN7drrVYBWUfisGEkZCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+5URevD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257DAC4CEF7;
	Thu, 13 Nov 2025 14:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763045379;
	bh=nKs52qLHIqK7qd0jS88AVYdqV64a1C2FUSD1K+jjxoE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=U+5URevDC6rpqGIg3pWbZwePqWLtTc0A2tpOER9JI4YuFF0xWa7jOLlFbhrOhv8IL
	 1T+oMrZK4WG0eNaDPrebnW+GmsTtXwtyzZE7o6BZyMUtt7EIAQhYfonBS24a1PR9My
	 FAzXJN+uihidzFxpQ7fyPUR8vza/AzZHhrsxPfFXuQm9VS9k7L2Rny9zXxlVv+r0Oe
	 PMegGJ2FnZyv0o4N8WRfSNqQbYHK93vmT36xImRFexU1sfmXHlg0eaI9OxdSTm7st2
	 LjKZDg7p4Wm/Lf6MemtE74eVwZ8oH3Zhw3zzKKqRJEd2+hSTGCFWIUuYf5S4Mkiy2f
	 aWpaKmoV0qbZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BB4EFCE0B94; Thu, 13 Nov 2025 06:49:38 -0800 (PST)
Date: Thu, 13 Nov 2025 06:49:38 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: bartosz.golaszewski@linaro.org, linux-kernel@vger.kernel.org,
	sfr@canb.auug.org.au, bigeasy@linutronix.de
Subject: Re: [PATCH -next] reset: Remove unused variables
Message-ID: <fdc04e4a-3930-41ca-9147-ce5bbf2d41ac@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8e6ec20e-8965-4b42-99fc-0462269ff2f1@paulmck-laptop>
 <def3319117b2d2d71d0585e69d648b1a0f217bc4.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def3319117b2d2d71d0585e69d648b1a0f217bc4.camel@pengutronix.de>

On Thu, Nov 13, 2025 at 10:51:50AM +0100, Philipp Zabel wrote:
> On Mi, 2025-11-12 at 12:59 -0800, Paul E. McKenney wrote:
> > Neither reset_lookup_mutex nor reset_lookup_list are used anymore, which
> > results in build errors, so remove them.  It would be best if this were
> > to be folded into commit 205b261463ff ("reset: remove legacy reset lookup
> > code"), the better for bisection efforts.
> > 
> > Reproduce on armv8 with:
> > 
> > tools/testing/selftests/rcutorture/bin/torture.sh --duration 10 --do-none --do-rt
> > 
> > Fixes: 205b261463ff ("reset: remove legacy reset lookup code") # -next
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 22f67fc77ae5..93575d5064a5 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -25,9 +25,6 @@
> >  static DEFINE_MUTEX(reset_list_mutex);
> >  static LIST_HEAD(reset_controller_list);
> >  
> > -static DEFINE_MUTEX(reset_lookup_mutex);
> > -static LIST_HEAD(reset_lookup_list);
> > -
> >  /* Protects reset_gpio_lookup_list */
> >  static DEFINE_MUTEX(reset_gpio_lookup_mutex);
> >  static LIST_HEAD(reset_gpio_lookup_list);
> 
> Thank you, just applied to reset/next for now:
> 
> [1/1] reset: Remove unused variables
>       https://git.pengutronix.de/cgit/pza/linux/commit/?id=3754bc97926e
> 
> I'll rebase this branch and squash this fix into 205b261463ff before
> sending a pull request. There's also the 25d4d4604d01 / f5c877fb74f4
> patch / revert pair that I should drop.

Thank you both!

							Thanx, Paul

