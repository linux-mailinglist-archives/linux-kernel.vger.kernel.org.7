Return-Path: <linux-kernel+bounces-736694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ED1B0A0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996A0A449B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6D2BCF4B;
	Fri, 18 Jul 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LDTUrCz5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DEFBA27;
	Fri, 18 Jul 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834438; cv=none; b=TuWrMAg3zYReAxUtB0hFnWgrz0wcslUcUOTLcTWLU9Gy/FC5OpartMiGf2f9IgkC9h7gkjSzC13o8ftB5E6zDeYwav2K0J3harvZ7GbIpGUkGYJJ64FBt06EUbhwb0Pql29Rn597OTPPE+fp/ATbE7n7j2zmWhTy0XWAcSgX0wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834438; c=relaxed/simple;
	bh=RSLPZfhWxQYnSXaCJXfPgeIgZNT7vJZLbF48MWYtaNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTHPS0Oq8e+mHDLuuAzQ11N+WLTyi5N5dMZBYBtbh6AmGNBtiiuZOIlbRUR22ic0+Po341TJ2EKtz4H4xiunMFOQiB9wCNhGyYedkaCYkPDyXW2uXYShEFg1FTT87FEkxsoRNAgjCP9CscQRFZRyRTe1PVpPrQm70s9v2Vx+CmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LDTUrCz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE4FC4CEEB;
	Fri, 18 Jul 2025 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752834438;
	bh=RSLPZfhWxQYnSXaCJXfPgeIgZNT7vJZLbF48MWYtaNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LDTUrCz5NxGOn4y5Ve3I/7yNBxscqW5Lgjiypa0IeUjDjyXq14HMmTry8p3Auu5E7
	 ZMeX0Lt/jCbdrN28fAj5RQcU+Ntwcku1HpPblnXgC8gC/wvGK6WjkwVc5Ljbx84+iv
	 icW4Wr9FHXSEneCTD86/B69kZT4Zne8q03jdyu3g=
Date: Fri, 18 Jul 2025 12:27:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rv: Ensure containers are registered first
Message-ID: <2025071835-enjoying-darn-f5d8@gregkh>
References: <20250718091850.2057864-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718091850.2057864-1-namcao@linutronix.de>

On Fri, Jul 18, 2025 at 11:18:50AM +0200, Nam Cao wrote:
> If rv_register_monitor() is called with a non-NULL parent pointer (i.e. by
> monitors inside a container), it is expected that the parent (a.k.a
> container) is already registered.
> 
> The containers seem to always be registered first. I suspect because of the
> order in Makefile. But nothing guarantees this.

Yes, linking order matters, and it does guarantee this.  We rely on
linking order in the kernel in many places.

> If this registering order is changed, "strange" things happen. For example,
> if the container is registered last, rv_is_container_monitor() incorrectly
> says this is NOT a container. .enable() is then called, which is NULL for
> container, thus we have a NULL pointer deref crash.
> 
> Guarantee that containers are registered first.
> 
> Fixes: cb85c660fcd4 ("rv: Add option for nested monitors and include sched")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/rv.h                                        | 5 +++++
>  kernel/trace/rv/monitors/pagefault/pagefault.c            | 4 ++--
>  kernel/trace/rv/monitors/rtapp/rtapp.c                    | 4 ++--
>  kernel/trace/rv/monitors/sched/sched.c                    | 4 ++--
>  kernel/trace/rv/monitors/sco/sco.c                        | 4 ++--
>  kernel/trace/rv/monitors/scpd/scpd.c                      | 4 ++--
>  kernel/trace/rv/monitors/sleep/sleep.c                    | 4 ++--
>  kernel/trace/rv/monitors/sncid/sncid.c                    | 4 ++--
>  kernel/trace/rv/monitors/snep/snep.c                      | 4 ++--
>  kernel/trace/rv/monitors/snroc/snroc.c                    | 4 ++--
>  kernel/trace/rv/monitors/tss/tss.c                        | 4 ++--
>  kernel/trace/rv/monitors/wip/wip.c                        | 4 ++--
>  kernel/trace/rv/monitors/wwnr/wwnr.c                      | 4 ++--
>  tools/verification/rvgen/rvgen/templates/container/main.c | 4 ++--
>  tools/verification/rvgen/rvgen/templates/dot2k/main.c     | 4 ++--
>  tools/verification/rvgen/rvgen/templates/ltl2k/main.c     | 4 ++--
>  16 files changed, 35 insertions(+), 30 deletions(-)

As there is no bug now, why is this a cc: stable patch?

thanks,

greg k-h

