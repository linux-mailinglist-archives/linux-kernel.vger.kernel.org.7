Return-Path: <linux-kernel+bounces-799521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D197B42D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD663B1CC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00512EE5E8;
	Wed,  3 Sep 2025 22:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9Ayp7RP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5F332F75C;
	Wed,  3 Sep 2025 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940236; cv=none; b=qWr5iqkMosG7uJ1rKj5iCIfYqwZ4jWuzdHdMh8BKLs2zkDq35B4q1e8Nz9eQaifdCVRhoTpg6eTA1aqlRREVLQzOv1LvgowMiHSc7qFXmfeQ7jFp5xvUc5HvqfL4Xp8ObcTC5svhfRt+QU9a8t+VFZrk/QxeHLlxOl4YO+3b+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940236; c=relaxed/simple;
	bh=L/sysX39C3UlP6FafL56XD/xuBjOo4mt6QKTtw/LEvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgVY+b3UqSlvcnXLTzpG3yc2MkuA2b6I9ZGORnixqTp7poy8/upJXNaAStBzcheu/pmXLGH37nGnyt44/T4DCLoxsT1mK7Otb24EQaUKQkzAfWDIUntfLEKO9JoVoA33G9eLThKM4zXyYkI45foFdXmrar+7FH6JkP6ku8p81uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9Ayp7RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D820BC4CEE7;
	Wed,  3 Sep 2025 22:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756940235;
	bh=L/sysX39C3UlP6FafL56XD/xuBjOo4mt6QKTtw/LEvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9Ayp7RPl5CEdDIZ9Blt89OJjcd2+QVfuchh8H542qOQVXwnmcOS7aQtpx7fnFPYV
	 DoqGsYfvBIeDJJHSNLHgk9yxmekkXlP5X/Y783DtE3O01PRd1lhROeK7y2n2/2l6SD
	 T5iAGQizjy1jff6lkqFaV4efTc5ChUOr5Mh5a6crju25/A+rT/guzJc6B4w2bKGQHV
	 AFO9QmSrSZ4Cx2ih1bRJ7m/3GQL0ZWX2dQRe4GRPc/6In4vuY33uFkS8gLR8ttkri/
	 8qlXY/UPGtIntU65mn6FWW8L2+N/nwFtsw8H/xkN6Zn3Av4vTAMzE6HdfAoRJeXx5v
	 Zhpi3aME3lUHg==
Date: Thu, 4 Sep 2025 00:57:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 00/15] Split sphinx call logic from docs
 Makefile
Message-ID: <20250904005711.142ebaae@foz.lan>
In-Reply-To: <873493p2vt.fsf@trenco.lwn.net>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
	<873493p2vt.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 03 Sep 2025 16:50:14 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > This series does a major cleanup at docs Makefile by moving the
> > actual doc build logic to a helper script (scripts/sphinx-build-wrapper).
> >
> > Such script was written in a way that it can be called either
> > directly or via a makefile. When running via makefile, it will
> > use GNU jobserver to ensure that, when sphinx-build is
> > called, the number of jobs will match at most what it is
> > specified by the "-j" parameter.  
> 
> So I've been playing with these a bit more, still trying to wrap my head
> around them.  I do wish that we were somehow ending up with something
> simpler than the status quo, but perhaps the problem domain just isn't
> that simple.

No, it isn't. We can do some cleanups later on by removing some env
vars, but still the sphinx-build logic we use is complex.

> > The first 3 patches do a cleanup at scripts/jobserver-exec
> > and moves the actual code to a library. Such library is used
> > by both the jobserver-exec command line and by sphinx-build-wrappper.  
> 
> These three seem OK, anyway, and could probably go in anytime.

Sure. Yet, we need them to ensure that sphinx-build-wrapper can
run jobs in parallel respecting make limits. If you prefer, you
can merge those three to reduce the number of patches I'll be
sending on the next version.

> > The change also gets rid of parallel-wrapper.sh, whose
> > functions are now part of the wrapper code.
> >
> > I added two patches at the end adding an extra target: "mandocs".
> > The patches came from a series I sent in separate with 2 patches.  
> 
> As for the rest, a couple of notes from where I am so far:
> 
> - The separation of the comments into their own patch is ... a bit
>   strange and makes the patches harder to review.  I plan to spend some
>   time looking at the end product, but still ...

Feel free to merge it after reviewing. The only reason I split it
is because you complained about the number of lines that the new
script have. With the split, it becomes clearer how much lines are
the actual code, and how much are the comments.

> - Acting on a hint from Akira, I note that "make O=elsewhere htmldocs"
>   no longer works - the output goes into Documentation/output
>   regardless.  That, I think, needs to be fixed.

Sure thing. I'll run some tests here and send a new version.

Thanks,
Mauro

