Return-Path: <linux-kernel+bounces-619948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7E1A9C3DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C19DC9C26BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC6238C1E;
	Fri, 25 Apr 2025 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipRQI3we";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alm4dm3r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD92356B8;
	Fri, 25 Apr 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573594; cv=none; b=NArM32PV+MdmS/LkdiWQE3XhyYfX8riefiMLwys3vF66q1J2dT8Y/cKI1Ey/4d0HmZiZDkow90Cy0dtVn7iVySvK74lBqDqzqIE5pImXMe/pduHOcdJmlthd1pEx3qJDTChU1kRspqEfKBE3IQv2o85Y30W+FKwK7JWxkt25glc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573594; c=relaxed/simple;
	bh=WNBCzVUdr2nMr5n1g8TkgRuxVBJ3OvFR4kRECxsx0dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7KGFIR8sWGRNRWUa3vPvvb4hZ17UsewXLW86IXo95m6tPeQ2tNl0R4S37/Drxnwreqe+ymqddy7JQXMfkTtoX5rNMTKqGyj4LVtJDodBn8Gp7FujxrP2tHPgR3AgGbPauAnNEdnU6QXb0NSFLlW9XPYR/kcwoW6G10pnwyQyuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipRQI3we; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alm4dm3r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Apr 2025 11:33:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745573590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttWMI3IxwHR18qgiavYlZ7Wrde1QtcOjDwO9mA75nyw=;
	b=ipRQI3weeZvi54Pj/z6HcZh1yPAgKNFKQqK2uWbTP9LrftmBQwUREE/oSZm7ZblPbYb4Oj
	GdXSeYy0BJWEjqn3WQ1MnPDUrrbWEoe1U5rp55kAZecRI4C/aCqPJdTgle5Ig6Xjc7ey+S
	8I+zBS8poyVvxWB2pwsqxb8Sg+aYnHqx0uQgJXvi5533F6oANT1p/aKHVcB/Rgw2NBxbW2
	/P2lspWZqQ49JL/uy7AWPuPnh2Uujao/IjcR7c7D+H81KgE6Y2Z0yVZj9a1vXjt+BC6v6y
	nWRdVosrfkI0/JeljEugAyMn7b9762C/4f5LD3rgL2ssCDV1JdKY5F/s52UtQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745573590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttWMI3IxwHR18qgiavYlZ7Wrde1QtcOjDwO9mA75nyw=;
	b=alm4dm3rSKXMYLXTb6ZshjlB0OGQ7Un5JbIALvYLgiN7mv3thBSkmwd+Oq7JF6FjGH5ML1
	WOcvexXwgKTCfmAA==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v4 20/22] rv: Add rtapp_sleep monitor
Message-ID: <20250425093309.RkeoCUBC@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
 <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de>
 <c321c7350ec10f9f358695acd765d2dbd067eeb2.camel@redhat.com>
 <20250425063456.NBE35YHR@linutronix.de>
 <169b8478-1eff-46b1-a782-f0cb529330bb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169b8478-1eff-46b1-a782-f0cb529330bb@redhat.com>

On Fri, Apr 25, 2025 at 07:35:36AM +0000, Gabriele Monaco wrote:
> 2025-04-25T06:35:09Z Nam Cao <namcao@linutronix.de>:
> > On Thu, Apr 24, 2025 at 03:55:34PM +0200, Gabriele Monaco wrote:
> >> I quickly tried the same with the other monitor comparing the number of
> >> errors with the page_faults generated by perf, but that didn't make too
> >> much sense. Perhaps I'm doing something wrong here though (the number
> >> reported by perf for page faults feels a bit too high).
> >>
> >> perf stat -e page-faults -e rv:error_pagefault stress-ng --cyclic 1
> >
> > This command run a non-real-time thread to do setup, and a cyclic real-time
> > thread. The number of pagefaults of each thread would be roughly
> > proportional to the code size executed by each thread. As the non-real-time
> > thread's code size is bigger, it sounds reasonable that the number of
> > pagefaults is greater than the number of monitor's warnings.
> 
> Mmh I guessed something like that, although numbers were a bit out of
> proportion (e.g. 500 page-faults and 8 errors), but again, I didn't check
> too carefully what happens under the hood.

Keep in mind that the non-real-time thread is calling into glibc. While
the real-time thread is a small loop doing nanosleep.

> > I tested the monitor on a real system. My system has some real-time audio
> > processing processes (pipewire, firefox running youtube), yours also
> > should.
> 
> That's a good point, also I didn't mention I was running these tests in a
> VM (virtme-ng), so the system stress is minimal and perhaps the setup
> triggers some different oddities (filesystems are overlays and some other
> things are set up differently from a real system).

Oddities are good, they make some corner cases appear.

Evidently I need to torture the monitors much more, let's see what else
shows up..

Best regards,
Nam

